<template>
  <div>
    <span v-if="loading">loading...</span>
    <div v-else :class="getFiltersPaneClass()">
      <md-field>
        <label for="countries">Countries</label>
        <md-select v-model="selectedCountries" name="countries" id="countries" md-dense multiple>
          <md-option
            v-for="item in countries"
            :key="item.ctryId"
            :value="item.ctryDescription"
          >{{item.ctryDescription}}</md-option>
        </md-select>
      </md-field>
      <md-field>
        <label for="categories">Categories</label>
        <md-select v-model="selectedCategories" name="categories" id="categories" md-dense multiple>
          <md-option
            v-for="item in categories"
            :key="item.catId"
            :value="item.longCategory"
          >{{item.longCategory}}</md-option>
        </md-select>
      </md-field>
      <md-field>
        <label for="chapters">Chapters</label>
        <md-select v-model="selectedChapters" name="chapters" id="chapters" md-dense multiple>
          <md-option
            v-for="item in chapters"
            :key="item.chapter"
            :value="item.longChapter"
          >{{item.longChapter}}</md-option>
        </md-select>
      </md-field>
      <md-field>
        <label for="hts">HTS</label>
        <md-select
          v-model="selectedHts"
          name="hts"
          id="hts"
          md-dense
          multiple
          :disabled="htsDisabled()"
        >
          <md-option v-for="item in hts" :key="item.hts" :value="item.longHts">{{item.longHts}}</md-option>
        </md-select>
      </md-field>
      <md-button @click="viewReport()" class="md-dense md-raised md-primary">View Report</md-button>
      <md-button @click="reset()">Reset</md-button>
    </div>
    <div :class="getReportClass()" id="embed-container" ref="embed-container"></div>
  </div>
</template>
<script>
import * as pbi from "powerbi-client";
import {
  getReport,
  getOtexaCountries,
  getOtexaCategories,
  getOtexaChapters
} from "@/utils/Repository";

export default {
  name: "OtexaAnnual",
  data: () => ({
    report: null,
    countries: null,
    categories: null,
    chapters: null,
    hts: null,
    selectedCountries: [],
    selectedCategories: [],
    selectedChapters: [],
    selectedHts: [],
    isReportVisible: false,
    loading: true
  }),
  async created() {
    this.countries = await getOtexaCountries();
    this.categories = await getOtexaCategories();
    this.chapters = await getOtexaChapters();

    this.report = await getReport(
      this.$route.params.workspaceName,
      this.$route.params.reportName
    );
    this.loading = false;
  },
  methods: {
    htsDisabled() {
      return (
        this.selectedCategories.length === 0 &&
        this.selectedChapters.length === 0
      );
    },
    getReportClass() {
      return this.isReportVisible ? "visible" : "hidden";
    },
    getFiltersPaneClass() {
      return this.isReportVisible ? "not-rendered" : "";
    },
    viewReport() {
      let filters = [];

      if (this.selectedCountries.length > 0) {
        filters.push(this.filter("Country", this.selectedCountries));
      }

      if (this.selectedCategories.length > 0) {
        filters.push(this.filter("Category", this.selectedCategories));
      }

      if (this.selectedChapters.length > 0) {
        filters.push(this.filter("Chapter", this.selectedChapters));
      }

      if (this.selectedHts.length > 0) {
        filters.push(this.filter("HTS", this.selectedHts));
      }

      var config = {
        id: this.report.powerBiReport.id,
        embedUrl: this.report.powerBiReport.embedUrl,
        accessToken: this.report.powerBiToken.token,
        type: "report",
        tokenType: pbi.models.TokenType.Embed,
        permissions: pbi.models.Permissions.All,
        filters
      };

      let embedContainer = this.$refs["embed-container"];
      window.powerbi.embed(embedContainer, config);

      this.isReportVisible = true;
    },
    reset() {
      this.selectedCountries = [];
      this.selectedCategories = [];
      this.selectedChapters = [];
      this.viewReport = false;
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
    }
  }
};
</script>
<style scoped>
#embed-container {
  height: 100vh;
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
</style>