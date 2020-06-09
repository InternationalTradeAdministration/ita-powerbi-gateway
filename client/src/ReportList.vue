<template>
  <div class="container">
    <header>
      <h1>{{ workspaceName }}</h1>
    </header>
    <span v-if="loading">loading...</span>
    <div v-else>
      <table>
        <th>
          Name
        </th>
        <tr v-for="r in reports" :key="r.id">
          <td>
            <router-link :to="buildReportUrl(r.name)">{{ r.name }}</router-link>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>
<script>
export default {
  name: 'ReportList',
  props: ['repository'],
  data: () => ({
    loading: true,
    workspaceName: null,
    reports: []
  }),
  async created () {
    this.workspaceName = this.$route.params.workspaceName
    let reports = await this.repository.listReports(this.workspaceName)
    this.reports = reports.sort((a, b) => (a.name > b.name ? 1 : -1))
    this.loading = false
  },
  methods: {
    buildReportUrl (reportName) {
      return '/workspace/' + this.workspaceName + '/report/' + reportName
    }
  }
}
</script>
