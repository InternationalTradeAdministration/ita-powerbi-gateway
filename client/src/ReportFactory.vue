<template>
  <div class="report-factory">
    <otexa-annual v-if="workspaceName.includes('OTEXA') && reportName === 'Annual Data v2'" :repository="repository" :pbi="pbi"/>
    <default v-else :repository="repository" :pbi="pbi" />
  </div>
</template>
<script>
import Default from "@/reports/Default";
import OtexaAnnual from "@/reports/OtexaAnnual";

export default {
  name: "ReportFactory",
  props: ["repository", "pbi"],
  components: {
    "default": Default,
    "otexa-annual": OtexaAnnual
  },
  data: () => ({
    workspaceName: null,
    reportName: null
  }),
  created() {
    this.workspaceName = this.$route.params.workspaceName;
    this.reportName = this.$route.params.reportName;
  }
};
</script>
<style scoped>
.report-factory {
  height: 100vh;
}
</style>