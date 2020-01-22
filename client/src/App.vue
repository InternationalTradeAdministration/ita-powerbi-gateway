<template>
  <div id="app">
    <h1 v-if="$route.name === 'Reports'">ITA Dataloader Reporting</h1>
    <router-view />
  </div>
</template>

<style scoped>
#app {
  margin: 10px;
}
</style>

<script>
export default {
  name: "App"
};
</script>

