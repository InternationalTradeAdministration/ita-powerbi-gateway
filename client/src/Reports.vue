<template>
  <div class="container">
    <div class="header">
      <span class="md-title">{{workspaceName}}</span>
    </div>
    <div class="content">
      <md-table v-model="reports">
        <md-table-row slot-scope="{ item }" slot="md-table-row">
          <md-table-cell md-label="Name">
            <router-link :to="buildReportIdUrl(item.id)">{{item.name}}</router-link>
          </md-table-cell>
          <md-table-cell md-label="Stable URL">
            <router-link :to="buildReportNameUrl(item.name)">URL</router-link>
          </md-table-cell>
        </md-table-row>
      </md-table>
    </div>
  </div>
</template>
<script>
import { getGroups, getReports } from "@/utils/Repository";

export default {
  name: "Reports",
  data: () => ({
    workspaceName: null,
    reports: []
  }),
  async created() {
    const groups = await getGroups();
    this.workspaceName = groups.find(
      g => g.id === this.$route.params.workspaceId
    ).name;
    this.reports = await getReports(this.$route.params.workspaceId);
  },
  methods: {
    buildReportIdUrl(reportId) {
      return (
        "/workspace/" + this.$route.params.workspaceId + "/report/" + reportId
      );
    },
    buildReportNameUrl(reportName) {
      return (
        "/workspace/" +
        this.$route.params.workspaceId +
        "/reportName/" +
        reportName
      );
    }
  }
};
</script>