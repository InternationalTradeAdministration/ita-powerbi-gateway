<template>
  <div class="report-factory">
    <otexa-msr-footwear-categories
      v-if="reportName.includes('MSR Categories') && reportName.includes('Footwear')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-msr-countries
      v-else-if="reportName.includes('MSR Countries')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-msr-categories
      v-else-if="reportName.includes('MSR Categories')"
      :repository="repository"
      :pbi="pbi"
      :reportName="reportName"
    />
    <otexa-merged-part-cat
      v-else-if="reportName.includes('Merged') || reportName.includes('Part')"
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
import OtexaMergedPartCat from '@/reports/OtexaMergedPartCat'
import OtexaMsrCountries from '@/reports/OtexaMsrCountries'
import OtexaMsrCategories from '@/reports/OtexaMsrCategories'
import OtexaMsrFootwearCategories from '@/reports/OtexaMsrFootwearCategories'

export default {
  name: 'ReportFactory',
  props: ['repository', 'pbi'],
  components: {
    default: Default,
    'otexa-annual': OtexaAnnual,
    'otexa-merged-part-cat': OtexaMergedPartCat,
    'otexa-msr-countries': OtexaMsrCountries,
    'otexa-msr-categories': OtexaMsrCategories,
    'otexa-msr-footwear-categories': OtexaMsrFootwearCategories,
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
