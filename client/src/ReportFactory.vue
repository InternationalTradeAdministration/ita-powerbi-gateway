<template>
  <div class="report-factory">
    <otexa-annual-footwear-divided
      v-if="workspaceName.includes('OTEXA') && reportName.includes('By')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-msr-footwear-categories
      v-else-if="workspaceName.includes('OTEXA') && reportName.includes('MSR Categories') && reportName.includes('Footwear')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-msr-countries
      v-else-if="workspaceName.includes('OTEXA') && reportName.includes('MSR Countries')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-msr-categories
      v-else-if="workspaceName.includes('OTEXA') && (reportName.includes('MSR Categories') || reportName.includes('MSR Groups'))"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-export-footwear
      v-else-if="workspaceName.includes('OTEXA') && reportName.includes('Export') && reportName.includes('Footwear')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-exports
      v-else-if="workspaceName.includes('OTEXA') && reportName.includes('Export')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-merged-part-cat
      v-else-if="workspaceName.includes('OTEXA') && (reportName.includes('Merged') || reportName.includes('Part'))"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-annual
      v-else-if="workspaceName.includes('OTEXA') && !reportName.includes('Metrics')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <default v-else :repository="repository" :pbi="pbi" />
  </div>
</template>
<script>
import Default from '@/reports/Default'
import OtexaAnnual from '@/reports/OtexaAnnual'
import OtexaExports from '@/reports/OtexaExports'
import OtexaMergedPartCat from '@/reports/OtexaMergedPartCat'
import OtexaMsrCountries from '@/reports/OtexaMsrCountries'
import OtexaMsrCategories from '@/reports/OtexaMsrCategories'
import OtexaMsrFootwearCategories from '@/reports/OtexaMsrFootwearCategories'
import OtexaExportFootwear from '@/reports/OtexaExportFootwear.vue'
import OtexaAnnualFootwearDivided from './reports/OtexaAnnualFootwearDivided.vue'

export default {
  name: 'ReportFactory',
  props: ['repository', 'pbi'],
  components: {
    default: Default,
    'otexa-annual': OtexaAnnual,
    'otexa-export-footwear': OtexaExportFootwear,
    'otexa-exports': OtexaExports,
    'otexa-merged-part-cat': OtexaMergedPartCat,
    'otexa-msr-countries': OtexaMsrCountries,
    'otexa-msr-categories': OtexaMsrCategories,
    'otexa-msr-footwear-categories': OtexaMsrFootwearCategories,
    'otexa-annual-footwear-divided': OtexaAnnualFootwearDivided,
  },
  data: () => ({
    workspaceName: null,
    reportName: null
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
