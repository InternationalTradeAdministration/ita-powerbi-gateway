<template>
  <router-view v-if="!loading" />
</template>

<script>
import Repository from '@/utils/Repository'

export default {
  name: "App",
  data: () => ({
    loading: true
  }),
  async created() {
    let repo = new Repository()
    await repo.getBearerToken();
    this.loading = false;
  }
};
</script>
<style>

html {
  font-family:  Arial, Verdana, sans-serif;
}

body {
  margin: 0;
}

h1 {
  font-size: 28px;
}

.container {
  margin: 0 22px;
}

iframe {
  border: none;
}

</style>
