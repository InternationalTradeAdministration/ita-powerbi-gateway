<template>
  <div>
    <span v-if="loading">loading...</span>
    <span v-else class="fullscreen" @click="fullscreen">Fullscreen</span>
    <div id="embed-container" ref="embed-container"></div>
  </div>
</template>
<script>
export default {
  name: 'Default',
  props: ['repository', 'pbi'],
  data: () => ({
    loading: true
  }),
  async created () {
    let r = await this.repository.generateToken(
      this.$route.params.workspaceName,
      this.$route.params.reportName
    )

    this.loading = false

    var embedConfig = {
      id: r.powerBiReport.id,
      embedUrl: r.powerBiReport.embedUrl,
      accessToken: r.powerBiToken.token,
      type: 'report',
      tokenType: this.pbi.models.TokenType.Embed,
      permissions: this.pbi.models.Permissions.All
    }

    let embedContainer = this.$refs['embed-container']
    window.powerbi.embed(embedContainer, embedConfig)
  },
  methods: {
    fullscreen () {
      let embedContainer = this.$refs['embed-container']
      const report = window.powerbi.get(embedContainer)
      report.fullscreen()
    }
  }
}
</script>
<style scoped>
#embed-container {
  height: 98vh;
}
.fullscreen {
  cursor: pointer;
  color: blue;
  text-decoration: underline;
}
</style>
