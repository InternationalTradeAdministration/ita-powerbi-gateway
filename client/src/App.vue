<template>
  <div id="app">
    <h1>ITA Dataloader Report Viewer</h1>
    {{fromTheBackEnd}}
  </div>
</template>

<style scoped>
</style>

<script>
export default {
  name: "app",
  components: {},
  data() {
    return {
      fromTheBackEnd: null,
      reports: []
    };
  },
  async created() {
    const reports = await fetch("/api/reports?businessUnit=otexa", {
      method: "GET",
      headers: {
        "Content-Type": "application/json"
      }
    });

    this.reports = await reports.json();
  },
  methods: {}
};
</script>

