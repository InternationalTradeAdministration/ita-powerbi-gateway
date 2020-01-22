<template>
  <div>
    <div v-if="loading">
      <span>loading...</span>
    </div>
    <div id="embed-container" ref="embed-container">
    </div>
  </div>
</template>
<script>
import * as pbi from "powerbi-client";

export default {
  name: "ReportViewer",
  data: () => ({
    loading: true
  }),
  async created() {
    let id = this.$route.query.reportId;
    let embedUrl = await this.get("/api/get-report?reportId=" + id).then(reportInfo => reportInfo.embedUrl)
    let accessToken = await this.get("/api/generate-embed-token?reportId=" + id)
    this.loading = false;

    var config = {
      id,
      embedUrl,
      accessToken,
      type: "report",
      tokenType: pbi.models.TokenType.Embed,
      permissions: pbi.models.Permissions.All
    };

    let embedContainer = this.$refs['embed-container']
    window.powerbi.embed(embedContainer, config) 
  },
  methods: {
    async get(url) {
      const response = await fetch(url, {
        method: "GET",
        headers: {
          "Content-Type": "application/json"
        }
      }
    );
    const responseJson = await response.json();
    return responseJson;
    }
  }
};
</script>
<style scoped>
#embed-container {
  height: 800px;
}
</style>