<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">
          <div class="filter-field">
            <label for="categories">Categories:</label>
            <select
              v-model="selectedCategories"
              name="categories"
              id="categories"
              size="20"
            >
              <option
                v-for="item in categories"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
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
  name: 'OtexaMsrCategories',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  data: () => ({
    report: null,
    categories: [],
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
      'Annual Data (MSR Category Notions)': [0, 1, 2, 11, 12, 14, 30, 31, 32, 40, 41, 42, 60, 61, 62, 80, 81, 82],
      'Annual Data (MSR Category Yarn)': [200, 201, 300, 301, 400, 600, 603, 604, 606, 607, 800],
      'Annual Data (MSR Category Fabric)': [218, 219, 220, 222, 223, 224, 225, 226, 227, 229, 313, 314, 315, 317, 326, 410, 414, 611, 613, 614, 615, 617, 618, 619, 620, 621, 622, 624, 625, 626, 627, 628, 629, 810],
      'Annual Data (MSR Category Apparel)': [237, 239, 330, 331, 332, 333, 334, 335, 336, 338, 339, 340, 341, 342, 345, 347, 348, 349, 350, 351, 352, 353, 359, 431, 432, 433, 434, 435, 436, 438, 439, 440, 442, 443, 444, 445, 446, 447, 448, 459, 630, 631, 632, 633, 634, 635, 636, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 659, 735, 736, 738, 739, 740, 741, 745, 751, 752, 758, 759, 831, 832, 833, 834, 835, 836, 838, 839, 840, 842, 843, 844, 845, 846, 847, 850, 851, 852, 858, 859],
      'Annual Data (MSR Category Made Ups)': [360, 361, 362, 363, 369, 464, 465, 469, 665, 666, 669, 670, 863, 870, 871, 899]
    }

    let allCategories = await this.repository.getOtexaCategories(source)
    this.categories = allCategories.filter(item => MSR_CATEGORIES[this.reportName].includes(item.catId))

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

      filters.push(this.filter('Country', 'All', [], false))

      let selectedCategories = this.categories
        .filter(c => [this.selectedCategories].includes(c.catId))
        .map(c => c.longCategory.trim())
      filters.push(this.filter('Category', 'In', selectedCategories, false))

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
