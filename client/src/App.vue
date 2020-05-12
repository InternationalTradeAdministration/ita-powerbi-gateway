<template>
  <div>
    <router-view v-if="!loading" />
  </div>
</template>

<style>
.header {
  padding: 16px;
}
</style>

<script>
import { getBearerToken } from "@/utils/Repository";

export default {
  name: "App",
  data: () => ({
    loading: true
  }),
  async created() {
    await getBearerToken()
    this.loading = false;
  }
};
</script>
