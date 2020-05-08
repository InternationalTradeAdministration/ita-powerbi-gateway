<template>
  <div>
    <otexa-annual v-if="workspaceName === 'OTEXA' && reportName === 'Annual Data v2'" />
    <default v-else />
  </div>
</template>
<script>
import Default from "@/reports/Default";
import OtexaAnnual from "@/reports/OtexaAnnual";

export default {
  name: "ReportFactory",
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