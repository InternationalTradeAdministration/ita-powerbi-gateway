<template>
  <div class="container">
    <div class="header">
      <span class="md-title">{{workspaceName}}</span>
    </div>
    <span v-if="loading">loading...</span>
    <div v-else class="content">
      <md-table v-model="reports" md-sort="name" md-sort-order="asc" md-card>
        <md-table-row slot-scope="{ item }" slot="md-table-row">
          <md-table-cell md-label="Name" md-sort-by="name">
            <router-link :to="buildReportUrl(item.name)">{{item.name}}</router-link>
          </md-table-cell>
        </md-table-row>
      </md-table>
    </div>
  </div>
</template>
<script>
import { listReports } from "@/utils/Repository";

export default {
  name: "Reports",
  data: () => ({
    loading: true,
    workspaceName: null,
    reports: []
  }),
  async created() {
    this.workspaceName = this.$route.params.workspaceName;
    let reports = await listReports(this.workspaceName);
    this.reports = reports.sort((a, b) => (a.name > b.name ? 1 : -1));
    this.loading = false;
  },
  methods: {
    buildReportUrl(reportName) {
      return "/workspace/" + this.workspaceName + "/report/" + reportName;
    }
  }
};
</script>