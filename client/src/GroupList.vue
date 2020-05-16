<template>
  <div class="container">
    <div>
      <h1>Workspaces</h1>
    </div>
    <div>
      <span v-if="loading">loading...</span>
      <table v-else>
        <tr>
          <th></th>
          <th>On Dedicated Capacity</th>
        </tr>
        <tr v-for="g in groups" :key="g.id">
          <td>
            <router-link :to="'/workspace/'+g.name">{{g.name}}</router-link>
          </td>
          <td class="dedicated-capacity">
            <span v-if="g.isOnDedicatedCapacity">✔</span>
            <span v-else>✖</span>
          </td>
        </tr>
      </table>
    </div>
    <a class="swagger" href="/swagger-ui.html" target="_blank">Swagger UI</a>
  </div>
</template>
<script>
import { pbiAdminListGroups } from "@/utils/Repository";

export default {
  name: "GroupList",
  data: () => ({
    groups: null,
    version: null,
    loading: true
  }),
  async created() {
    let groups = await pbiAdminListGroups(null);
    this.groups = groups.sort((a, b) => (a.name > b.name ? 1 : -1));
    this.loading = false;
  }
};
</script>
<style scoped>
.swagger {
  position: absolute;
  bottom: 10px;
  right: 20px;
}

.dedicated-capacity {
  text-align: center;
}
</style>
