<template>
  <div class="container">
    <div class="header">
      <span class="md-title">Power BI Workspaces</span>
    </div>
    <div class="content">
      <md-table v-model="groups">
        <md-table-row slot-scope="{ item }" slot="md-table-row">
          <md-table-cell md-label="Workspace ID">
            <router-link :to="'/workspace/'+item.id">{{item.name}}</router-link>
          </md-table-cell>
          <md-table-cell md-label="On Dedicated Capacity">
            <span>{{item.isOnDedicatedCapacity}}</span>
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
    groups: []
  }),
  async created() {
    this.groups = await getGroups();
  }
};
</script>
