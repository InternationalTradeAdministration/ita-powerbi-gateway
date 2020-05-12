<template>
  <div class="container">
    <span v-if="loading">loading...</span>
    <div v-else class="header">
      <span class="md-title">Workspaces</span>
    </div>
    <div class="content">
      <md-table v-model="groups" md-sort="name" md-sort-order="asc" md-card>
        <md-table-row slot-scope="{ item }" slot="md-table-row" :id="item.id">
          <md-table-cell md-label="Name" md-sort-by="name">
            <router-link :to="'/workspace/'+item.name">{{item.name}}</router-link>
          </md-table-cell>
        </md-table-row>
      </md-table>
    </div>
  </div>
</template>
<script>
import { getGroups } from "@/utils/Repository";

export default {
  name: "Reports",
  data: () => ({
    loading: true,
    groups: []
  }),
  async created() {
    let groups = await getGroups();
    this.groups = groups.sort((a, b) => (a.name > b.name ? 1 : -1));
    this.loading = false;
  }
};
</script>
