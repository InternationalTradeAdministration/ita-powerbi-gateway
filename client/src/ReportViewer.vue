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
import { getReports, getReport, generateEmbedToken } from '@/utils/Repository';

export default {
  name: "ReportViewer",
  data: () => ({
    loading: true
  }),
  async created() {
    let id;
    if (this.$route.query.reportId) {
      id = this.$route.query.reportId;
    } else {
      const reports = await getReports() 
      id = reports.find(r => r.name === this.$route.query.reportName).id
    }

    let embedUrl = await getReport(id).then(reportInfo => reportInfo.embedUrl)
    let accessToken = await generateEmbedToken(id)
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
  }
};
</script>
<style scoped>
#embed-container {
  height: 800px;
}
</style>