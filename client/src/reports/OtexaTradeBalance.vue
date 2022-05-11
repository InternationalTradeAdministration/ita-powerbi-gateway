<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-fields">
          <div class="regions" v-if="!this.isShowFTAPartnerCountries && !this.isShowMajorCountries">
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
          <div class="filter-field" v-if="this.isShowFTAPartnerCountries || this.isShowMajorCountries">
            <label for="selectedCountries">{{this.isShowFTAPartnerCountries ? 'FTA Partners' : 'Major Countries'}}</label>
            <select
              v-model="selectedCountries"
              name="selectedCountries"
              id="selectedCountries"
              multiple
              size="25"
            >
              <option
                v-for="item in countries"
                :key="item.ctryNumber"
                :value="item.ctryNumber"
              >{{ item.ctryDescription }}</option>
            </select>
          </div>
          <div class="filter-field">
            <label for="aggGroups">Aggregate Groups:</label>
            <select
              v-model="selectedAggGroups"
              name="aggGroups"
              id="aggGroups"
              multiple
              size="5"
            >
              <option
                v-for="item in aggGroups"
                :key="item"
                :value="item"
                >{{ item }}</option
              >
            </select>
          </div>
          <div class="filter-field">
            <label for="tradeFlow">Trade Flow:</label>
            <select
              v-model="tradeFlow"
              name="tradeFlow"
              id="tradeFlow"
              size="3"
            >
              <option value='Imports'>Imports</option>
              <option value='Exports'>Exports</option>
              <option value='Trade Balance'>Trade Balance</option>
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
import { FTA_Partners, Major_Countries } from './FTA_and_Major_Countries'
import { uniqNames } from '@/utils/helpers'
export default {
  name: 'OtexaTradeBalance',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  mixins: [TokenExpirationListenerMixin],
  data: () => ({
    report: null,
    isShowFTAPartnerCountries: null,
    isShowMajorCountries: null,
    source: null,
    countries: [],
    selectedCountries: [],
    aggGroups: ["Total", "Apparel", "Fabric", "Made-up", "Yarn"],
    selectedAggGroups: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
    tradeFlow: null,
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
    this.source = 'ANNUAL'
    this.countries = []

    if (this.reportName.endsWith('FTA')) {
      this.isShowFTAPartnerCountries = true
      let allCountries = await this.repository.getOtexaCountries(this.source)
      this.countries = allCountries.filter(country => FTA_Partners.includes(country.ctryNumber))
    } else if (this.reportName.endsWith('Major')) {
      this.isShowMajorCountries = true
      let allCountries = await this.repository.getOtexaCountries(this.source)
      this.countries = allCountries.filter(country => Major_Countries.includes(country.ctryNumber))
    } else {
      this.countries = await this.repository.getOtexaCountries(this.source)

      this['CountryGroups'] = this.countries.filter(country => country.ctryGroup === 'Country Groups')
      let AFRICA = this.countries.filter(country => country.ctryGroup === 'Africa')
      this['Africa'] = uniqNames(AFRICA, "ctryDescription")
      let ASIA = this.countries.filter(country => country.ctryGroup === 'Asia')
      this['Asia'] = uniqNames(ASIA, "ctryDescription")
      let OCEANIA = this.countries.filter(country => country.ctryGroup === 'Australia and Oceania')
      this['AustraliaAndOceania'] = uniqNames(OCEANIA, "ctryDescription")
      let EUROPE = this.countries.filter(country => country.ctryGroup === 'Europe')
      this['Europe'] = uniqNames(EUROPE, "ctryDescription")
      let NCAMERICA = this.countries.filter(country => country.ctryGroup === 'North and Central America')
      this['NorthAndCentralAmerica'] = uniqNames(NCAMERICA, "ctryDescription")
      let SAMERICA = this.countries.filter(country => country.ctryGroup === 'South America')
      this['SouthAmerica'] = uniqNames(SAMERICA, "ctryDescription")
    }

    this.tradeFlow = "Trade Balance"

    this.loading = false
  },
  methods: {
    getReportClass () {
      return this.isReportVisible ? 'sub-content visible' : 'hidden'
    },

    async viewReport () {
      let filters = []
      let allSelectedCountries = [].concat(
        this.selectedCountryGroups, this.selectedAfrica, this.selectedAsia, this.selectedAustraliaAndOceania, this.selectedEurope, this.selectedNorthAndCentralAmerica, this.selectedSouthAmerica
        , this.selectedCountries
        )

      if (allSelectedCountries.length > 0) {
        let selectedCountries = this.countries
          .filter(c => allSelectedCountries.includes(c.ctryNumber))
          .map(c => c.ctryDescription.trim())
        filters.push(this.filter('Country', 'In', selectedCountries, false, false))
      } else if (this.isShowFTAPartnerCountries || this.isShowMajorCountries) {
        let selectedCountries = this.countries.map(c => c.ctryDescription)
        filters.push(this.filter('Country', 'In', selectedCountries, false, false))
      } else {
        filters.push(this.filter('Country', 'All', [], false, false))
      }

      if (this.selectedAggGroups.length > 0) {
        filters.push(this.filter('Aggregate Group', 'In', this.selectedAggGroups, false, false))
      } else {
        filters.push(this.filter('Aggregate Group', 'All', [], false, false))
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
        embedContainer.children[0].style.height = null;

        report.setFilters(filters)
        let pages = await report.getPages()
        let tradeBalancePage = pages.filter(p => p.displayName === 'Trade Balance')[0]
        let importsPage = pages.filter(p => p.displayName === 'Imports')[0]
        let exportsPage = pages.filter(p => p.displayName === 'Exports')[0]
        if (this.tradeFlow === 'Imports') {
          importsPage.setActive();
        } else if (this.tradeFlow === 'Exports') {
          exportsPage.setActive();
        } else {
          tradeBalancePage.setActive();
        }
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountries = []
      this.selectedCountryGroups = []
      this.selectedAfrica = []
      this.selectedAsia = []
      this.selectedAustraliaAndOceania = []
      this.selectedEurope = []
      this.selectedNorthAndCentralAmerica = []
      this.selectedSouthAmerica = []
      this.selectedAggGroups = []
      this.tradeFlow = "Trade Balance"
      this.isReportVisible = false
    },
    filter (column, operator, values, requireSingleSelection, isHidden = false) {
      let table = 'OTEXA_TRADE_BALANCE_VW';
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
      let table = 'OTEXA_TRADE_BALANCE_VW';
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
