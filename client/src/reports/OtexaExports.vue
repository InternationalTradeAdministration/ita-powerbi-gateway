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
              <option :value="false">Group</option>
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
            <label for="groups">Groups:</label>
            <select
              v-model="selectedGroups"
              name="groups"
              id="groups"
              multiple
              size="20"
            >
              <option
                v-for="item in groups"
                :key="item.groupId"
                :value="item.groupId"
                >{{ item.groupId }}</option
              >
            </select>
          </div>
          <div class="filter-field">
            <label for="displayIn">Display In:</label>
            <select
              v-model="displayIn"
              name="displayIn"
              id="displayIn"
              size="2"
            >
              <option value='DOLLARS'>DOLLARS</option>
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
  name: 'OtexaExports',
  props: ['repository', 'pbi', 'reportName'],
  components: {
    toolbar: Toolbar
  },
  mixins: [TokenExpirationListenerMixin],
  data: () => ({
    report: null,
    countries: [],
    groups: [],
    selectedCountries: [],
    selectedGroups: [],
    displayIn: [],
    isReportVisible: false,
    loading: true,
    loadingReport: true,
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
    this.onlyCountry = (this.$route.query.onlyCountry || this.reportName.includes('Group'))
      ? (this.$route.query.onlyCountry === 'true' || this.reportName.includes('Country'))
      : true

    let source = 'EXPORT'
    this.countries = await this.repository.getOtexaCountries(source)
    this.groups = await this.repository.getOtexaExportGroups()

    Object.keys(this.countryRegions).forEach(region => {
      this.countryRegions[region] = this.countries.filter(country => country.ctryGroup === region)
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
      let groupPageFilters = []
      let countryPageFilters = []

      if (this.displayIn.length === 0) {
        filters.push(this.filter('Display In', 'In', ['DOLLARS'], true))
      } else {
        filters.push(this.filter('Display In', 'In', [this.displayIn], true))
      }

      if (this.selectedCountries.length > 0) {
        let selectedCountries = this.countries
          .filter(c => this.selectedCountries.includes(c.ctryId))
          .map(c => c.ctryDescription.trim())
        filters.push(this.filter('Country', 'In', selectedCountries, false))
      } else {
        filters.push(this.filter('Country', 'All', [], false))
      }

      if (this.selectedGroups.length > 0) {
        let selectedCategories = this.groups
          .filter(g => this.selectedGroups.includes(g.groupId))
          .map(g => g.groupId)
        filters.push(this.filter('Group_ID', 'In', selectedCategories, false))
      } else {
        filters.push(this.filter('Group_ID', 'All', [], false))
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
        let groupPage = pages.filter(p => p.displayName === 'Group')[0]
        let countryPage = pages.filter(p => p.displayName === 'Country')[0]

        report.setFilters(filters)
        groupPage.setFilters(groupPageFilters)
        countryPage.setFilters(countryPageFilters)

        if (!this.onlyCountry) {
          countryPage.setActive()
        }
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountries = []
      this.selectedGroups = []
      this.displayIn = 'DOLLARS'
      this.isReportVisible = false
    },
    filter (column, operator, values, requireSingleSelection) {
      let table = 'OTEXA_EXPORTS_VW';
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
