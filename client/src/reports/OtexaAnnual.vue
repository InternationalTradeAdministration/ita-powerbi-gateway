<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">
          <div class="filter-field">
            <label>Data By:</label>
            <select v-model="onlyCountry" @click="reset()" size="2">
              <option :value="true">Country</option>
              <option :value="false">Category</option>
            </select>
          </div>
          <div class="regions" v-if="onlyCountry">
            <div class="filter-field" v-for="(countries, region) in countryRegions" :key="region">
              <label for="region">{{ region }}:</label>
              <select
                v-model="selectedCountries"
                :name=region
                :id=region
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
          <div class="filter-field years" v-if="reportName.includes('Historical')">
            <label for="years">*Years:</label>
            <select
              v-model="selectedYears"
              name="years"
              id="years"
              multiple
              size="20"
            >
              <option
                v-for="item in years"
                :key="item[yearKey]"
                :value="item[yearKey]"
              >{{ item[yearKey] }}</option>
            </select>
          </div>
          <div class="filter-field" v-if="reportName.includes('Footwear')">
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
          <div class="filter-field" v-else>
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
        <p v-if="(!onlyCountry || reportName.includes('Historical'))">
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
import TokenExpirationListenerMixin from '../TokenExpirationListenerMixin'
export default {
  name: 'OtexaAnnual',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  mixins: [TokenExpirationListenerMixin],
  data: () => ({
    report: null,
    countries: [],
    categories: [],
    chapters: [],
    hts: [],
    years: [],
    yearKey: null,
    selectedCountries: [],
    selectedCategories: [],
    selectedChapters: [],
    selectedHts: [],
    selectedYears: [],
    displayIn: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
    loadingHts: false,
    onlyCountry: null,
    countryRegions: {
      'Country Groups': [],
      'Africa': [],
      'Asia': [],
      'Australia and Oceania': [],
      'Europe': [],
      'North and Central America': [],
      'South America': [],
    }
  }),
  async created () {
    this.onlyCountry = (this.$route.query.onlyCountry || this.reportName.includes('Category'))
      ? (this.$route.query.onlyCountry === 'true' || this.reportName.includes('Country'))
      : true

    let source = this.reportName.includes('Footwear')
      ? 'ANNUAL_FOOTWEAR'
      : 'ANNUAL'

    this.countries = await this.repository.getOtexaCountries(source)
    this.categories = await this.repository.getOtexaCategories(source)

    Object.keys(this.countryRegions).forEach(region => {
      this.countryRegions[region] = this.countries.filter(country => country.ctryGroup === region)
    })

    if (this.reportName.includes('Footwear')) {
      this.years = await this.repository.getOtexaFootwearYears()
      this.yearKey = 'dataKey'
    } else {
      let years = await this.repository.getOtexaYears()
      this.years = years.filter(year => !year.headerDescription.includes('Quarter'))
      this.yearKey = 'headerDescription'
    }

    let chapters = await this.repository.getOtexaChapters()

    const footwearChapters = [39, 41, 42, 43, 46, 64, 65, 83, 94, 96]
    if (source === 'ANNUAL_FOOTWEAR') {
      this.chapters = Object.values(chapters).filter(item => footwearChapters.includes(item.chapter))
    } else { this.chapters = chapters }

    this.displayIn = 'DOLLARS'

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
      let htsPageFilters = []

      if (this.displayIn.length === 0) {
        filters.push(this.filter('Display In', 'In', ['DOLLARS'], true))
      } else {
        filters.push(this.filter('Display In', 'In', [this.displayIn], true))
      }

      if (this.selectedCountries.length === 0) {
        filters.push(this.filter('Country', 'All', [], false))
      } else {
        let selectedCountries = this.countries
          .filter(c => this.selectedCountries.includes(c.ctryId))
          .map(c => c.ctryDescription.trim())
        if ( selectedCountries.includes('World') || selectedCountries.includes('WORLD') ) {
          filters.push(this.filter('Country', 'All', [], false))
        } else {
          filters.push(this.filter('Country', 'In', selectedCountries, false, true))
        }
      }

      if (this.selectedCategories.length > 0) {
        let selectedCategories = this.categories
          .filter(c => this.selectedCategories.includes(c.catId))
          .map(c => c.longCategory.trim())
        filters.push(this.filter('Category', 'In', selectedCategories, false, true))
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

      htsPageFilters.push(this.advancedFilter('HTS', 'And', 'IsNotBlank', null))

      if (this.reportName.includes('Historical')) {
        if (this.selectedYears.length > 0) {
          let selectedYears = this.selectedYears
          filters.push(this.filter('Year', 'In', selectedYears, false))
        } else {
          filters.push(this.filter('Year', 'All', [], false))
        }
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
          filterPaneEnabled: true
        }
      }

      let embedContainer = this.$refs['embed-container']

      window.powerbi.embed(embedContainer, embedConfig)

      const report = window.powerbi.get(embedContainer)
      report.on('loaded', async () => {
        this.loadingReport = false
        this.setTokenExpirationListener(this.report.powerBiToken.expiration)

        let pages = await report.getPages()
        let htsPage = pages.filter(p => p.displayName === 'HTS')[0]
        let countryPage = pages.filter(p => p.displayName === 'Country')[0]

        report.setFilters(filters)
        htsPage.setFilters(htsPageFilters)

        if (!this.onlyCountry) {
          countryPage.setActive()
        }
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountries = []
      this.selectedCategories = []
      this.selectedChapters = []
      this.selectedHts = []
      this.selectedYears = []
      this.hts = []
      this.displayIn = 'DOLLARS'
      this.isReportVisible = false
    },
    filter (column, operator, values, requireSingleSelection, isHidden = false) {
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
        filterType: 1,
        displaySettings: {
          isHiddenInViewMode: isHidden
        }
      }
    },
    advancedFilter (column, logicalOperator, operator, value) {
      let table;
        if (this.reportName.includes('Footwear')) {
        table = 'OTEXA_ANNUAL_FOOTWEAR_VW'
      } else {
        table = 'OTEXA_ANNUAL_VW'
      }
      return {
        logicalOperator,
        conditions: [
          {
            operator: operator,
            value: value
          }
        ],
        $schema: 'http://powerbi.com/product/schema#advanced',
        target: {
          column,
          table
        },
        filterType: 0,
        displaySettings: {
          isHiddenInViewMode: true
        }
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

.filter-fields, .regions {
  display: inline-flex;
  flex-wrap: wrap;
}

.regions select {
  width: 150px;
}

input,
label {
  display: block;
}

.years select{
  width: 225px;
}

[multiple] {
  min-width: 100px;
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
