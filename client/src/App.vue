<template>
  <div id="app">
    <vue-headful title="ITA Dataloader Reporting" />
    <h1>ITA Dataloader Reporting</h1>
    <md-table v-model="reports">
      <md-table-row slot-scope="{ item }" slot="md-table-row">
        <md-table-cell md-label="Report Name">{{item.name}}</md-table-cell>
        <md-table-cell md-label="Web URL">
          <a :href="item.webUrl" target="_blank">{{item.webUrl}}</a>
        </md-table-cell>
        <md-table-cell md-label="Embed URL">{{item.embedUrl}}</md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>

<style scoped>
#app {
  margin: 10px;
}
</style>

<script>
export default {
  name: "app",
  components: {},
  data() {
    return {
      reports: []
    };
  },
  async created() {
    const reports = await fetch("/api/list-reports", {
      method: "GET",
      headers: {
        "Content-Type": "application/json"
      }
    });
    const response = await reports.json();
    this.reports = response.value;
  },
  methods: {}
};
</script>

