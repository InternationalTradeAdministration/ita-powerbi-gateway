<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">
          <div class="filter-field">
            <label for="countries">Countries:</label>
            <select
              v-model="selectedCountries"
              name="countries"
              id="countries"
              size="20"
            >
              <option
                v-for="item in countries"
                :key="item.ctryId"
                :value="item.ctryId"
                >{{ item.ctryDescription }}</option
              >
            </select>
          </div>
          <div class="filter-field">
            <label for="displayIn">Display In:</label>
            <select
              v-model="displayIn"
              name="displayIn"
              id="displayIn"
              size="3"
            >
              <option value='DOLLARS'>DOLLARS</option>
              <option value='SME'>SME</option>
              <option value='UNITS'>UNITS</option>
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
export default {
  name: 'OtexaMsrCountries',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  data: () => ({
    report: null,
    countries: [],
    categories: [],
    selectedCountries: [],
    displayIn: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
  }),
  async created () {
    let source = this.reportName.includes('Footwear')
      ? 'ANNUAL_FOOTWEAR'
      : 'ANNUAL'
    this.countries = await this.repository.getOtexaCountries(source)
    this.categories = await this.repository.getOtexaCategories(source)

    this.report = await this.repository.generateToken(
      this.$route.params.workspaceName,
      this.$route.params.reportName
    )

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

      let selectedCountries = this.countries
        .filter(c => [this.selectedCountries].includes(c.ctryId))
        .map(c => c.ctryDescription.trim())
      filters.push(this.filter('Country', 'In', selectedCountries, false))

      filters.push(this.filter('Category', 'All', [], false))

      filters.push(this.filter('Chapter', 'All', [], false))

      filters.push(this.filter('HTS', 'All', [], false))

      if (this.reportName.includes('Historical')) {
        filters.push(this.filter('Year', 'All', [], false))
      }

      var embedConfig = {
        id: this.report.powerBiReport.id,
        embedUrl: this.report.powerBiReport.embedUrl,
        accessToken: this.report.powerBiToken.token,
        type: 'report',
        tokenType: this.pbi.models.TokenType.Embed,
        permissions: this.pbi.models.Permissions.All,
        settings: {
          filterPaneEnabled: false
        }
      }

      let embedContainer = this.$refs['embed-container']

      window.powerbi.embed(embedContainer, embedConfig)

      const report = window.powerbi.get(embedContainer)
      report.on('loaded', async () => {
        this.loadingReport = false

        report.setFilters(filters)
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountries = []
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

[multiple] {
  width: 282px;
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
