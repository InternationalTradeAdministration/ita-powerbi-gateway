<template>
  <md-table v-model="reports">
    <md-table-row slot-scope="{ item }" slot="md-table-row">
      <md-table-cell md-label="Reports">
        <router-link :to="'/view?reportId='+item.id">{{item.name}}</router-link>
      </md-table-cell>
       <md-table-cell md-label="Stable URL">
        <router-link :to="'/view?reportName='+item.name">URL</router-link>
      </md-table-cell>
    </md-table-row>
  </md-table>
</template>
<script>
import { getReports } from '@/utils/Repository';

export default {
  name: "Reports",
  data: () => ({
    reports: []
  }),
  async created() {
    this.reports = await getReports()
  }
};
</script>