<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">

          <div class="filter-field">
            <label for="categoryFootwearProducts">Footwear, Leather and Fur Products:</label>
            <select
              v-model="selectedCategories"
              name="categoryFootwearProducts"
              id="categoryFootwearProducts"
              size="20"
            >
              <option
                v-for="item in categoryFootwearProducts"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>

          <div class="filter-field">
            <label for="categoryTravelGoods">Travelgoods:</label>
            <select
              v-model="selectedCategories"
              name="categoryTravelGoods"
              id="categoryTravelGoods"
              size="20"
            >
              <option
                v-for="item in categoryTravelGoods"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>
        </div>

        <div class="filter-pane">
          <div class="filter-field">
            <label for="displayIn">Display In:</label>
            <select
              v-model="displayIn"
              name="displayIn"
              id="displayIn"
              size="2"
            >
              <option value='DOLLARS'>DOLLARS</option>
              <option value='QTY'>QTY</option>
            </select>
          </div>
        </div>

        <div class="filter-buttons">
          <button @click="viewReport()" id="submit-button">Submit</button>
          <button @click="reset()" id="reset-button">Reset</button>
        </div>
      </div>
    </div>
    <div :class="getReportClass()">
      <toolbar :loadingReport="loadingReport" :pbi="pbi">
        <button @click="isReportVisible = false">
          <img src="/images/back-arrow.svg" />
        </button>
      </toolbar>
      <div id="embed-container" ref="embed-container"></div>
    </div>
  </div>
</template>
<script>
import Toolbar from '@/Toolbar'
import TokenExpirationListenerMixin from '../TokenExpirationListenerMixin'
export default {
  name: 'OtexaMsrFootwearCategories',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  mixins: [TokenExpirationListenerMixin],
  data: () => ({
    report: null,
    categoryFootwearProducts: [],
    categoryTravelGoods: [],
    allCategories: [],
    selectedCategories: [],
    displayIn: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
  }),
  async created () {
    let source = this.reportName.includes('Footwear')
      ? 'ANNUAL_FOOTWEAR'
      : 'ANNUAL'
    const MSR_CATEGORIES = {
      'categoryFootwearProducts': [10, 100, 101, 105, 110, 111, 112, 113, 114, 119, 120, 132, 133, 134, 139, 140, 141, 142, 143, 144],
      'categoryTravelGoods': [190, 191, 192 ,193, 195, 196],
    }

    let allCategories = await this.repository.getOtexaCategories(source)
    this.allCategories = allCategories

    Object.keys(MSR_CATEGORIES).forEach(cat => {
      this[cat] = allCategories.filter(item => MSR_CATEGORIES[cat].includes(item.catId))
    })

    this.displayIn = 'DOLLARS'

    this.loading = false
  },
  methods: {
    getReportClass () {
      return this.isReportVisible ? 'sub-content visible' : 'hidden'
    },

    async viewReport () {
      let filters = []

      if (this.displayIn.length === 0) {
        filters.push(this.filter('Display In', 'In', ['DOLLARS'], true))
      } else {
        filters.push(this.filter('Display In', 'In', [this.displayIn], true))
      }

      filters.push(this.filter('Country', 'All', [], false))

      let selectedCategories = this.allCategories
        .filter(c => [this.selectedCategories].includes(c.catId))
        .map(c => c.longCategory.trim())
      filters.push(this.filter('Category', 'In', selectedCategories, false))

      filters.push(this.filter('Chapter', 'All', [], false))
      filters.push(this.filter('HTS', 'All', [], false))

      if (this.reportName.includes('Historical')) {
        filters.push(this.filter('Year', 'All', [], false))
      }

      this.report = await this.repository.generateToken(
        this.$route.params.workspaceName,
        this.$route.params.reportName
      )

      var embedConfig = {
        id: this.report.powerBiReport.id,
        embedUrl: this.report.powerBiReport.embedUrl,
        accessToken: this.report.powerBiToken.token,
        type: 'report',
        tokenType: this.pbi.models.TokenType.Embed,
        permissions: this.pbi.models.Permissions.All,
        settings: {
          filterPaneEnabled: false,
          navContentPaneEnabled: false,
        }
      }

      let embedContainer = this.$refs['embed-container']

      window.powerbi.embed(embedContainer, embedConfig)

      const report = window.powerbi.get(embedContainer)
      report.on('loaded', async () => {
        this.loadingReport = false
        this.setTokenExpirationListener(this.report.powerBiToken.expiration)

        report.setFilters(filters)

        let pages = await report.getPages()
        pages.filter(p => p.displayName === 'Country')[0].setActive()
      })
      this.isReportVisible = true
    },
    reset () {
      this.selectedCategories = []
      this.displayIn = 'DOLLARS'
      this.isReportVisible = false
    },
    filter (column, operator, values, requireSingleSelection) {
      let table;
      if (this.reportName.includes('Footwear')) {
        table = 'OTEXA_ANNUAL_FOOTWEAR_VW'
      } else {
        table = 'OTEXA_ANNUAL_VW'
      }
      return {
        requireSingleSelection,
        operator,
        values,
        $schema: 'http://powerbi.com/product/schema#basic',
        target: {
          column,
          table
        },
        filterType: 1
      }
    }
  }
}
</script>
<style scoped>
.sub-content {
  display: flex;
  flex-flow: column;
  height: 100%;
}

.visible {
  visibility: visible;
  height: 100%;
}

.hidden {
  visibility: hidden;
}

.filter-fields {
  display: flex;
}

input,
label {
  display: block;
}

.filter-field {
  padding: 8px 12px;
}

.filter-field label {
  margin-bottom: 8px;
}

.filter-field select {
  padding: 4px 8px;
}

.filter-buttons {
  display: flex;
  justify-content: flex-end;
  padding: 8px;
}

.filter-buttons button {
  margin: 20px 0 0 20px;
}

p {
  padding: 8px;
}
</style>
