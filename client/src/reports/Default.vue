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
  name: "Default",
  data: () => ({
    loading: true
  }),
  async created() {
    let r = await getReport(
      this.$route.params.workspaceName,
      this.$route.params.reportName
    );

    this.loading = false;

    var embedConfig = {
      id: r.powerBiReport.id,
      embedUrl: r.powerBiReport.embedUrl,
      accessToken: r.powerBiToken.token,
      type: "report",
      tokenType: pbi.models.TokenType.Embed,
      permissions: pbi.models.Permissions.All
    };

    let embedContainer = this.$refs["embed-container"];
    window.powerbi.embed(embedContainer, embedConfig);
  }
};
</script>
<style scoped>
#embed-container {
  height: 100vh;
}
</style>