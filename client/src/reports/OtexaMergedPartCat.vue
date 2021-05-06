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
                size="20"
              >
                <option
                  v-for="item in countries"
                  :key="item.ctryNumber"
                  :value="item.ctryNumber"
                  >{{ item.ctryDescription }}</option
                >
              </select>
            </div>
          </div>
          <div class="filter-field" v-if="!onlyCountry">
            <label for="categories">Categories:</label>
            <select
              v-if="reportName.includes('Merged')"
              v-model="selectedCategories"
              name="categories"
              id="categories"
              size="20"
            >
              <option
                v-for="item in categories"
                :key="item.mergedCategory"
                :value="item.mergedCategory"
                >{{item.mergedCategory}} - {{ item.description }}</option
              >
            </select>
            <select
              v-if="reportName.includes('Part')"
              v-model="selectedCategories"
              name="categories"
              id="categories"
              size="37"
            >
              <option
                v-for="item in categories"
                :key="item.partCategory"
                :value="item.partCategory"
                >{{item.partCategory}}</option
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
import TokenExpirationListenerMixin from '../TokenExpirationListenerMixin'
export default {
  name: 'OtexaMergedPartCat',
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
    selectedCountries: null,
    selectedCategories: [],
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
    this.onlyCountry = false

    this.source = this.reportName.includes('Merged')
      ? 'MERGED_CAT'
      : 'PART_CAT'

    this.countries = await this.repository.getOtexaCountries(this.source)
    this.categories = this.reportName.includes('Merged') 
      ? await this.repository.getOtexaMergedCategories() 
      : await this.repository.getOtexaPartCategories()

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

      if (this.displayIn.length === 0) {
        filters.push(this.filter('Display In', 'In', ['DOLLARS'], true))
      } else {
        filters.push(this.filter('Display In', 'In', [this.displayIn], true))
      }

      if (this.selectedCountries != null) {
        let selectedCountries = this.countries
          .filter(c => [this.selectedCountries].includes(c.ctryNumber))
          .map(c => c.ctryDescription.trim())
        filters.push(this.filter('Country', 'In', selectedCountries, false))
      } else {
        filters.push(this.filter('Country', 'All', [], false))
      }

      if (this.reportName.includes('Merged')) {
        if (this.selectedCategories.length > 0) {
          let selectedCategories = this.categories
            .filter(c => this.selectedCategories.includes(c.mergedCategory))
            .map(c => c.mergedCategory.trim())
          filters.push(this.filter('Merged Category', 'In', selectedCategories, false))
        } else {
          filters.push(this.filter('Merged Category', 'All', [], false))
        }
      }

      if (this.reportName.includes('Part')) {
        if (this.selectedCategories.length > 0) {
          let selectedCategories = this.categories
            .filter(c => this.selectedCategories.includes(c.partCategory))
            .map(c => c.partCategory.trim())
          filters.push(this.filter('Part Category', 'In', selectedCategories, false))
        } else {
          filters.push(this.filter('Part Category', 'All', [], false))
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

        if (!this.onlyCountry) {
          let pages = await report.getPages()
          pages.filter(p => p.displayName === 'Country')[0].setActive()
        }
      })

      this.isReportVisible = true
    },
    reset () {
      this.selectedCountries = null
      this.selectedCategories = []
      this.displayIn = 'DOLLARS'
      this.isReportVisible = false
    },
    filter (column, operator, values, requireSingleSelection, isHidden = false) {
      let table;
      if (this.reportName.includes('Merged')) {
        table = 'OTEXA_MERGED_CAT_VW'
      } else {
        table = 'OTEXA_PART_CAT_VW'
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
