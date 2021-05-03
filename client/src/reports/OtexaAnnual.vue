<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">
          <div v-if="!reportName.includes('Monthly')" class="filter-field">
            <label>Data By:</label>
            <select v-model="onlyCountry" @click="reset()" size="2">
              <option :value="true">Country</option>
              <option :value="false">Category</option>
            </select>
          </div>
          <div class="regions" v-if="onlyCountry || reportName.includes('Monthly')">
            <div class="filter-field">
              <label for="CountryGroups">Country Groups:</label>
              <select
                v-model="selectedCountryGroups"
                :name=CountryGroups
                :id=CountryGroups
                multiple
                size="20"
              >
                <option
                  v-for="item in CountryGroups"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="Africa">Africa:</label>
              <select
                v-model="selectedAfrica"
                :name=Africa
                :id=Africa
                multiple
                size="20"
              >
                <option
                  v-for="item in Africa"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="Asia">Asia:</label>
              <select
                v-model="selectedAsia"
                :name=Asia
                :id=Asia
                multiple
                size="20"
              >
                <option
                  v-for="item in Asia"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="AustraliaAndOceania">Australia and Oceania:</label>
              <select
                v-model="selectedAustraliaAndOceania"
                :name=AustraliaAndOceania
                :id=AustraliaAndOceania
                multiple
                size="20"
              >
                <option
                  v-for="item in AustraliaAndOceania"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="Europe">Europe:</label>
              <select
                v-model="selectedEurope"
                :name=Europe
                :id=Europe
                multiple
                size="20"
              >
                <option
                  v-for="item in Europe"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="NorthAndCentralAmerica">North and Central America:</label>
              <select
                v-model="selectedNorthAndCentralAmerica"
                :name=NorthAndCentralAmerica
                :id=NorthAndCentralAmerica
                multiple
                size="20"
              >
                <option
                  v-for="item in NorthAndCentralAmerica"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
            <div class="filter-field">
              <label for="SouthAmerica">South America:</label>
              <select
                v-model="selectedSouthAmerica"
                :name=SouthAmerica
                :id=SouthAmerica
                multiple
                size="20"
              >
                <option
                  v-for="item in SouthAmerica"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
          </div>
          <div class="filter-field" v-if="!onlyCountry || reportName.includes('Monthly')">
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
          <div class="filter-field" v-if="!onlyCountry || reportName.includes('Monthly')">
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
          <div class="filter-field" v-if="!onlyCountry || reportName.includes('Monthly')">
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
          <div class="filter-field years" v-if="reportName.includes('Historical') || reportName.includes('Monthly')">
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
          <div class="filter-field" v-if="reportName.includes('Footwear') && !reportName.includes('Monthly')">
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
          <div class="filter-field" v-else-if="!reportName.includes('Monthly')">
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
        <p v-if="(!onlyCountry || reportName.includes('Historical')) || reportName.includes('Monthly')">
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
    source: null,
    countries: [],
    categories: [],
    chapters: [],
    hts: [],
    years: [],
    yearKey: null,
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
    CountryGroups: [],
    selectedCountryGroups: [],
    Africa: [],
    selectedAfrica: [],
    Asia: [],
    selectedAsia: [],
    AustraliaAndOceania: [],
    selectedAustraliaAndOceania: [],
    Europe: [],
    selectedEurope: [],
    NorthAndCentralAmerica: [],
    selectedNorthAndCentralAmerica: [],
    SouthAmerica: [],
    selectedSouthAmerica: [],
  }),
  async created () {
    this.onlyCountry = (this.$route.query.onlyCountry || this.reportName.includes('Category'))
      ? (this.$route.query.onlyCountry === 'true' || this.reportName.includes('Country'))
      : true

    this.source = this.reportName.includes('Footwear')
      ? 'ANNUAL_FOOTWEAR'
      : 'ANNUAL'

    this.countries = await this.repository.getOtexaCountries(this.source)
    this.categories = await this.repository.getOtexaCategories(this.source)

    this['CountryGroups'] = this.countries.filter(country => country.ctryGroup === 'Country Groups')
    this['Africa'] = this.countries.filter(country => country.ctryGroup === 'Africa')
    this['Asia'] = this.countries.filter(country => country.ctryGroup === 'Asia')
    this['AustraliaAndOceania'] = this.countries.filter(country => country.ctryGroup === 'Australia and Oceania')
    this['Europe'] = this.countries.filter(country => country.ctryGroup === 'Europe')
    this['NorthAndCentralAmerica'] = this.countries.filter(country => country.ctryGroup === 'North and Central America')
    this['SouthAmerica'] = this.countries.filter(country => country.ctryGroup === 'South America')

    if (this.reportName.includes('Monthly') && this.reportName.includes('Footwear')) {
      this.years = await this.repository.getOtexaMonthlyYears('MONTHLY_FOOTWEAR')
      this.yearKey = 'year'
    } else if (this.reportName.includes('Monthly')) {
      this.years = await this.repository.getOtexaMonthlyYears('MONTHLY')
      this.yearKey = 'year'
    } else if (this.reportName.includes('Footwear')) {
      this.years = await this.repository.getOtexaFootwearYears()
      this.yearKey = 'dataKey'
    } else {
      let years = await this.repository.getOtexaYears()
      this.years = years.filter(year => !year.headerDescription.includes('Quarter'))
      this.yearKey = 'headerDescription'
    }

    this.chapters = await this.repository.getOtexaChapters(this.source)

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
          this.selectedChapters,
          this.source
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
      let allSelectedCountries = [].concat(this.selectedCountryGroups, this.selectedAfrica, this.selectedAsia, this.selectedAustraliaAndOceania, this.selectedEurope, this.selectedNorthAndCentralAmerica, this.selectedSouthAmerica)

      if (!this.reportName.includes('Monthly')) {
        if (this.displayIn.length === 0) {
          filters.push(this.filter('Display In', 'In', ['DOLLARS'], true, true))
        } else {
          filters.push(this.filter('Display In', 'In', [this.displayIn], true, true))
        }
      }

      if (allSelectedCountries.length > 0) {
        let selectedCountries = this.countries
          .filter(c => allSelectedCountries.includes(c.ctryNumber))
          .map(c => c.ctryDescription.trim())
        filters.push(this.filter('Country', 'In', selectedCountries, false, false))
      } else {
        filters.push(this.filter('Country', 'All', [], false, false))
      }

      if (this.selectedCategories.length > 0) {
        let selectedCategories = this.categories
          .filter(c => this.selectedCategories.includes(c.catId))
          .map(c => c.longCategory.trim())
        filters.push(this.filter('Category', 'In', selectedCategories, false, false))
      } else {
        filters.push(this.filter('Category', 'All', [], false, false))
      }

      if (this.selectedChapters.length > 0) {
        let selectedChapters = this.chapters
          .filter(c => this.selectedChapters.includes(c.chapter))
          .map(c => c.longChapter.trim())
        filters.push(this.filter('Chapter', 'In', selectedChapters, false, false))
      } else {
        filters.push(this.filter('Chapter', 'All', [], false, false))
      }

      if (this.selectedHts.length > 0) {
        let selectedHts = this.hts
          .filter(c => this.selectedHts.includes(c.hts))
          .map(c => c.longHts.trim())
        filters.push(this.filter('HTS', 'In', selectedHts, false, false))
      } else {
        filters.push(this.filter('HTS', 'All', [], false, false))
      }

      htsPageFilters.push(this.advancedFilter('HTS', 'And', 'IsNotBlank', null))

      if (this.reportName.includes('Historical') || this.reportName.includes('Monthly')) {
        if (this.selectedYears.length > 0) {
          let selectedYears = this.selectedYears
          filters.push(this.filter('Year', 'In', selectedYears, false, false))
        } else {
          filters.push(this.filter('Year', 'All', [], false, false))
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
          filterPaneEnabled: true,
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
          let htsPage = pages.filter(p => p.displayName === 'HTS')[0]
          let countryPage = pages.filter(p => p.displayName.includes('Country'))[0]

          htsPage.setFilters(htsPageFilters)

          if (!this.onlyCountry) {
            countryPage.setActive()
          }
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountryGroups = []
      this.selectedAfrica = []
      this.selectedAsia = []
      this.selectedAustraliaAndOceania = []
      this.selectedEurope = []
      this.selectedNorthAndCentralAmerica = []
      this.selectedSouthAmerica = []
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
      if (this.reportName.includes('Monthly') && this.reportName.includes('Footwear')) {
        table = 'OTEXA_MONTHLY_FOOTWEAR_IMPORTS_VW'
      } else if (this.reportName.includes('Footwear')) {
        table = 'OTEXA_ANNUAL_FOOTWEAR_VW'
      } else if (this.reportName.includes('Monthly')) {
        table = 'OTEXA_MONTHLY_IMPORTS_VW'
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
      if (this.reportName.includes('Monthly') && this.reportName.includes('Footwear')) {
        table = 'OTEXA_MONTHLY_FOOTWEAR_IMPORTS_VW'
      } else if (this.reportName.includes('Footwear')) {
        table = 'OTEXA_ANNUAL_FOOTWEAR_VW'
      } else if (this.reportName.includes('Monthly')) {
        table = 'OTEXA_MONTHLY_IMPORTS_VW'
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
