<template>
  <md-table v-model="reports">
    <md-table-row slot-scope="{ item }" slot="md-table-row">
      <md-table-cell md-label="Reports">
        <router-link :to="'/view?reportId='+item.id">{{item.name}}</router-link>
      </md-table-cell>
    </md-table-row>
  </md-table>
</template>
<script>
export default {
  name: "Reports",
  data: () => ({
    reports: []
  }),
  async created() {
    const reports = await fetch("/api/list-reports", {
      method: "GET",
      headers: {
        "Content-Type": "application/json"
      }
    });
    const response = await reports.json();
    this.reports = response.value;
  }
};
</script>