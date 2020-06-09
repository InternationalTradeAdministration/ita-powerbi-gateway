<template>
  <div class="container">
    <header>
      <h1>Workspaces</h1>
    </header>
    <div>
      <span v-if="loading">loading...</span>
      <table v-else>
        <tr>
          <th>Name</th>
          <th>On Dedicated Capacity</th>
        </tr>
        <tr v-for="g in groups" :key="g.id">
          <td>
            <router-link :to="'/workspace/' + g.name">{{ g.name }}</router-link>
          </td>
          <td class="dedicated-capacity">
            <span v-if="g.isOnDedicatedCapacity">✔</span>
            <span v-else>✖</span>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>
<script>
export default {
  name: 'GroupList',
  props: ['repository'],
  data: () => ({
    groups: null,
    version: null,
    loading: true
  }),
  async created () {
    let groups = await this.repository.listGroups()
    this.groups = groups.sort((a, b) => (a.name > b.name ? 1 : -1))
    this.loading = false
  }
}
</script>
<style scoped>
.dedicated-capacity {
  text-align: center;
}
</style>
