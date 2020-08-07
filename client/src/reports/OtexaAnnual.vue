<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">
          <div class="filter-field">
            <label>Data By:</label>
            <select v-model="onlyCountry" @click="reset()">
              <option :value="true">Country</option>
              <option :value="false">Category</option>
            </select>
          </div>
          <div class="filter-field" v-if="onlyCountry">
            <label for="countries">Countries:</label>
            <select
              v-model="selectedCountries"
              name="countries"
              id="countries"
              multiple
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
          <div class="filter-field" v-if="!onlyCountry">
            <label for="categories">Categories:</label>
            <select
              v-model="selectedCategories"
              name="categories"
              id="categories"
              multiple
              size="20"
              @change="updateHts()"
            >
              <option
                v-for="item in categories"
                :key="item.catId"
                :value="item.catId"
                >{{ item.longCategory }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="!onlyCountry">
            <label for="chapters">Chapters:</label>
            <select
              v-model="selectedChapters"
              name="chapters"
              id="chapters"
              multiple
              size="20"
              @change="updateHts()"
            >
              <option
                v-for="item in chapters"
                :key="item.chapter"
                :value="item.chapter"
                >{{ item.longChapter }}</option
              >
            </select>
          </div>
          <div class="filter-field" v-if="!onlyCountry">
            <label for="hts">HTS:</label>
            <span v-if="loadingHts">loading...</span>
            <select
              v-else
              v-model="selectedHts"
              name="hts"
              id="hts"
              multiple
              size="20"
            >
              <option v-for="item in hts" :key="item.hts" :value="item.hts">{{
                item.longHts
              }}</option>
            </select>
          </div>
        </div>
        <p v-if="!onlyCountry">
          *Multiple selections will be added together (use the Shift key for
          sequential selections and the Ctrl key for non-sequential ones).
        </p>
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
  name: 'OtexaAnnual',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  data: () => ({
    report: null,
    countries: [],
    categories: [],
    chapters: [],
    hts: [],
    selectedCountries: [],
    selectedCategories: [],
    selectedChapters: [],
    selectedHts: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
    loadingHts: false,
    onlyCountry: null
  }),
  async created () {
    this.onlyCountry = this.$route.query.onlyCountry
      ? this.$route.query.onlyCountry === 'true'
      : true

    let source = this.reportName.includes('Footwear')
      ? 'ANNUAL_FOOTWEAR'
      : 'ANNUAL'
    this.countries = await this.repository.getOtexaCountries(source)
    this.categories = await this.repository.getOtexaCategories(source)
    this.chapters = await this.repository.getOtexaChapters()

    this.report = await this.repository.generateToken(
      this.$route.params.workspaceName,
      this.$route.params.reportName
    )

    this.loading = false
  },
  methods: {
    getReportClass () {
      return this.isReportVisible ? 'sub-content visible' : 'hidden'
    },
    async updateHts () {
      if (!this.htsDisabled()) {
        this.loadingHts = true
        this.hts = await this.repository.getOtexaHts(
          this.selectedCategories,
          this.selectedChapters
        )
        this.loadingHts = false
      }
    },
    htsDisabled () {
      return !(
        this.selectedCategories.length > 0 || this.selectedChapters.length > 0
      )
    },
    async viewReport () {
      let filters = []

      filters.push(this.filter('Display In', 'In', ['DOLLARS'], true))

      if (this.selectedCountries.length > 0) {
        let selectedCountries = this.countries
          .filter(c => this.selectedCountries.includes(c.ctryId))
          .map(c => c.ctryDescription.trim())
        filters.push(this.filter('Country', 'In', selectedCountries, false))
      } else {
        filters.push(this.filter('Country', 'All', [], false))
      }

      if (this.selectedCategories.length > 0) {
        let selectedCategories = this.categories
          .filter(c => this.selectedCategories.includes(c.catId))
          .map(c => c.longCategory.trim())
        filters.push(this.filter('Category', 'In', selectedCategories, false))
      } else {
        filters.push(this.filter('Category', 'All', [], false))
      }

      if (this.selectedChapters.length > 0) {
        let selectedChapters = this.chapters
          .filter(c => this.selectedChapters.includes(c.chapter))
          .map(c => c.longChapter.trim())
        filters.push(this.filter('Chapter', 'In', selectedChapters, false))
      } else {
        filters.push(this.filter('Chapter', 'All', [], false))
      }

      if (this.selectedHts.length > 0) {
        let selectedHts = this.hts
          .filter(c => this.selectedHts.includes(c.hts))
          .map(c => c.longHts.trim())
        filters.push(this.filter('HTS', 'In', selectedHts, false))
      } else {
        filters.push(this.filter('HTS', 'All', [], false))
      }

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
          filterPaneEnabled: (this.reportName.includes('No Filter')) ? false : true
        }
      }

      let embedContainer = this.$refs['embed-container']

      window.powerbi.embed(embedContainer, embedConfig)

      const report = window.powerbi.get(embedContainer)
      report.on('loaded', async () => {
        this.loadingReport = false

        report.setFilters(filters)

        if (!this.onlyCountry) {
          let pages = await report.getPages()
          pages.filter(p => p.displayName === 'Country')[0].setActive()
        }
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountries = []
      this.selectedCategories = []
      this.selectedChapters = []
      this.selectedHts = []
      this.hts = []
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
