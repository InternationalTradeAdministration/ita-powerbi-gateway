<template>
  <router-view v-if="!loading" />
</template>

<script>
import { getBearerToken } from "@/utils/Repository";

export default {
  name: "App",
  data: () => ({
    loading: true
  }),
  async created() {
    await getBearerToken();
    this.loading = false;
  }
};
</script>
<style>
@font-face {
  font-family: "Merriweather";
  src: url("./fonts/Merriweather.woff") format("woff");
}

html {
  font-family:  Arial, Verdana, sans-serif;
}

body {
  margin: 0;
}

h1 {
  font-family: "Merriweather", Arial, Verdana, sans-serif;
  font-size: 28px;
}

.container {
  margin: 0 22px;
}

iframe {
  border: none;
}

</style>
