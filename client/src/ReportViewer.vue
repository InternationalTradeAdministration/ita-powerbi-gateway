<template>
  <div>
    <div v-if="loading">
      <span>loading...</span>
    </div>
    <div id="embed-container" ref="embed-container"></div>
  </div>
</template>
<script>
import * as pbi from "powerbi-client";
import { getReportById, getReportByName } from "@/utils/Repository";

export default {
  name: "ReportViewer",
  data: () => ({
    loading: true
  }),
  async created() {
    let report;
    if (this.$route.params.reportId) {
      report = await getReportById(
        this.$route.params.workspaceId,
        this.$route.params.reportId
      );
    } else {
      report = await getReportByName(
        this.$route.params.workspaceId,
        this.$route.params.reportName
      );
    }

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
  }
};
</script>
<style scoped>
#embed-container {
  height: 98vh;
}
</style>