<template>
  <div>
    <span v-if="loading">loading...</span>
    <div v-else-if="!isReportVisible">
      <div class="filter-pane">
        <div class="filter-field">
          <label for="countries">Countries</label>
          <select v-model="selectedCountries" name="countries" id="countries" multiple>
            <option
              v-for="item in countries"
              :key="item.ctryId"
              :value="item.ctryId"
            >{{item.ctryDescription}}</option>
          </select>
        </div>
        <div class="filter-field">
          <label for="categories">Categories</label>
          <select
            v-model="selectedCategories"
            name="categories"
            id="categories"
            multiple
            @change="updateHts()"
          >
            <option
              v-for="item in categories"
              :key="item.catId"
              :value="item.catId"
            >{{item.longCategory}}</option>
          </select>
        </div>
        <div class="filter-field">
          <label for="chapters">Chapters</label>
          <select
            v-model="selectedChapters"
            name="chapters"
            id="chapters"
            multiple
            @change="updateHts()"
          >
            <option
              v-for="item in chapters"
              :key="item.chapter"
              :value="item.chapter"
            >{{item.longChapter}}</option>
          </select>
        </div>
        <div class="filter-field">
          <label for="hts">HTS</label>
          <span v-if="loadingHts">loading...</span>
          <select v-else v-model="selectedHts" name="hts" id="hts" multiple>
            <option v-for="item in hts" :key="item.hts" :value="item.hts">{{item.longHts}}</option>
          </select>
        </div>
        <div class="filter-buttons">
          <button @click="viewReport()">Submit</button>
          <button @click="reset()">Reset</button>
        </div>
      </div>
      <p>*Multiple selections will be added together (use the Shift key for sequential selections and the Ctrl key for non-sequential ones).</p>
    </div>
    <div :class="getReportClass()">
      <button class="back-button" @click="back()">
        <img src="/images/back-arrow.svg" />
      </button>
      <div id="embed-container" ref="embed-container"></div>
    </div>
  </div>
</template>
<script>
import * as pbi from "powerbi-client";

export default {
  name: "OtexaAnnual",
  props: ['repository'],
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
    loadingHts: false
  }),
  async created() {
    this.countries = await this.repository.getOtexaCountries();
    this.categories = await this.repository.getOtexaCategories();
    this.chapters = await this.repository.getOtexaChapters();

    this.report = await this.repository.getReport(
      this.$route.params.workspaceName,
      this.$route.params.reportName
    );
    this.loading = false;
  },
  methods: {
    getReportClass() {
      return this.isReportVisible ? "visible" : "hidden";
    },
    getHtsClass() {
      return this.hts.length === 0 ? "not-rendered" : "";
    },
    async updateHts() {
      if (!this.htsDisabled()) {
        this.loadingHts = true;
        this.hts = await this.repository.getOtexaHts(
          this.selectedCategories,
          this.selectedChapters
        );
        this.loadingHts = false;
      }
    },
    htsDisabled() {
      return (
        this.selectedCategories.length === 0 ||
        this.selectedChapters.length === 0
      );
    },
    viewReport() {
      let filters = [];

      if (this.selectedCountries.length > 0) {
        let selectedCountries = this.countries
          .filter(c => this.selectedCountries.includes(c.ctryId))
          .map(c => c.ctryDescription);
        filters.push(this.filter("Country", selectedCountries));
      }

      if (this.selectedCategories.length > 0) {
        let selectedCategories = this.categories
          .filter(c => this.selectedCategories.includes(c.catId))
          .map(c => c.longCategory);
        filters.push(this.filter("Category", selectedCategories));
      }

      if (this.selectedChapters.length > 0) {
        let selectedChapters = this.chapters
          .filter(c => this.selectedChapters.includes(c.chapter))
          .map(c => c.longChapter);
        filters.push(this.filter("Chapter", selectedChapters));
      }

      if (this.selectedHts.length > 0) {
        let selectedHts = this.hts
          .filter(c => this.selectedHts.includes(c.hts))
          .map(c => c.longHts);
        filters.push(this.filter("HTS", selectedHts));
      }

      var embedConfig = {
        id: this.report.powerBiReport.id,
        embedUrl: this.report.powerBiReport.embedUrl,
        accessToken: this.report.powerBiToken.token,
        type: "report",
        tokenType: pbi.models.TokenType.Embed,
        permissions: pbi.models.Permissions.All,
        settings: {
          filterPaneEnabled: true
        },
        filters
      };

      let embedContainer = this.$refs["embed-container"];
      window.powerbi.embed(embedContainer, embedConfig);

      this.isReportVisible = true;
    },
    reset() {
      this.selectedCountries = [];
      this.selectedCategories = [];
      this.selectedChapters = [];
      this.selectedHts = [];
      this.hts = [];
      this.isReportVisible = false;
    },
    filter(column, values) {
      return {
        $schema: "http://powerbi.com/product/schema#basic",
        values,
        operator: "In",
        target: {
          column,
          table: "OTEXA_EXE_HTS_VW2"
        },
        filterType: 1
      };
    },
    back() {
      this.isReportVisible = false;
    }
  }
};
</script>
<style scoped>
#embed-container {
  height: 95vh;
}

.not-rendered {
  display: none;
}

.visible {
  visibility: visible;
}

.hidden {
  visibility: hidden;
}

.filter-pane {
  display: flex;
}

.filter-field label {
  font-weight: bold;
}

.filter-field {
  display: grid;
}

.filter-field select {
  height: 148px;
}

.filter-buttons button {
  margin: 20px 0 0 20px;
}

.back-button {
  border: none;
  background: white;
  cursor: pointer;
}
</style>