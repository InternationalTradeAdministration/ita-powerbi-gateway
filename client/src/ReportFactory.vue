<template>
  <div class="report-factory">
    <otexa-msr-footwear-categories
      v-if="workspaceName.includes('OTEXA') && OtexaReportNames.OtexaMsrFootwearCategories.includes(reportName)"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-msr-countries
      v-else-if="workspaceName.includes('OTEXA') && OtexaReportNames.OtexaMsrCountries.includes(reportName)"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-msr-categories
      v-else-if="workspaceName.includes('OTEXA') && OtexaReportNames.OtexaMsrCategories.includes(reportName)"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-exports
      v-else-if="workspaceName.includes('OTEXA') && OtexaReportNames.OtexaExports.includes(reportName)"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-merged-part-cat
      v-else-if="workspaceName.includes('OTEXA') && OtexaReportNames.OtexaMergedPartCat.includes(reportName)"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-trade-balance
      v-else-if="workspaceName.includes('OTEXA') && OtexaReportNames.OtexaTradeBalance.includes(reportName)"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-annual
      v-else-if="workspaceName.includes('OTEXA') && OtexaReportNames.OtexaAnnual.includes(reportName)"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <default v-else :repository="repository" :pbi="pbi" />
  </div>
</template>
<script>
import Default from '@/reports/Default'
import OtexaReportNames from '@/reports/OtexaReportNames'
import OtexaAnnual from '@/reports/OtexaAnnual'
import OtexaExports from '@/reports/OtexaExports'
import OtexaMergedPartCat from '@/reports/OtexaMergedPartCat'
import OtexaMsrCountries from '@/reports/OtexaMsrCountries'
import OtexaMsrCategories from '@/reports/OtexaMsrCategories'
import OtexaMsrFootwearCategories from '@/reports/OtexaMsrFootwearCategories'
import OtexaTradeBalance from '@/reports/OtexaTradeBalance'

export default {
  name: 'ReportFactory',
  props: ['repository', 'pbi'],
  components: {
    default: Default,
    'otexa-annual': OtexaAnnual,
    'otexa-exports': OtexaExports,
    'otexa-merged-part-cat': OtexaMergedPartCat,
    'otexa-msr-countries': OtexaMsrCountries,
    'otexa-msr-categories': OtexaMsrCategories,
    'otexa-msr-footwear-categories': OtexaMsrFootwearCategories,
    'otexa-trade-balance': OtexaTradeBalance,
  },
  data: () => ({
    workspaceName: null,
    reportName: null,
    OtexaReportNames: OtexaReportNames,
  }),
  created () {
    this.workspaceName = this.$route.params.workspaceName
    this.reportName = this.$route.params.reportName
  }
}
</script>
<style scoped>
.report-factory {
  height: 100vh;
}
</style>
