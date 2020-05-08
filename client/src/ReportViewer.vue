<template>
  <div>
    <span v-if="loading">loading...</span>
    <div id="embed-container" ref="embed-container"></div>
  </div>
</template>
<script>
import * as pbi from "powerbi-client";
import { getReport } from "@/utils/Repository";

export default {
  name: "ReportViewer",
  data: () => ({
    loading: true
  }),
  async created() {
    let report = await getReport(
      this.$route.params.workspaceName,
      this.$route.params.reportName
    );

    this.loading = false;

    var config = {
      id: report.id,
      embedUrl: report.embedUrl,
      accessToken: report.embedToken,
      type: "report",
      tokenType: pbi.models.TokenType.Embed,
      permissions: pbi.models.Permissions.All
    };

    let embedContainer = this.$refs["embed-container"];
    window.powerbi.embed(embedContainer, config);

    if (this.$route.query.fullscreen === "true") {
      this.fullscreen();
    }
  },
  methods: {
    fullscreen() {
      let embedContainer = this.$refs["embed-container"];
      let report = window.powerbi.get(embedContainer);
      report.fullscreen();
    }
  }
};
</script>
<style scoped>
#embed-container {
  height: 100vh;
}
</style>