<template>
  <div class="container">
    <div class="header">
      <span class="md-title">Workspaces</span>
      <div class="swagger">
        <a href="/swagger-ui.html" target="_blank">Swagger UI</a>
      </div>
    </div>
    <div class="content">
      <span v-if="loading">loading...</span>
      <md-table v-else v-model="groups" md-sort="name" md-sort-order="asc" md-card>
        <md-table-row slot-scope="{ item }" slot="md-table-row" :id="item.id">
          <md-table-cell md-label="Name" md-sort-by="name">
            <router-link :to="'/workspace/'+item.name">{{item.name}}</router-link>
          </md-table-cell>
          <md-table-cell md-label="isOnDedicatedCapacity">{{item.isOnDedicatedCapacity}}</md-table-cell>
        </md-table-row>
      </md-table>
    </div>
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
  display: flex;
  justify-content: flex-end;
}
</style>
