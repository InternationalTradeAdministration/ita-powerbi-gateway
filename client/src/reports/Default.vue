<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <toolbar v-else :loadingReport="loadingReport" :pbi="pbi" />
    <div id="embed-container" ref="embed-container"></div>
  </div>
</template>
<script>
import Toolbar from '@/Toolbar'
export default {
  name: 'Default',
  props: ['repository', 'pbi'],
  components: {
    'toolbar': Toolbar
  },
  data: () => ({
    loading: true,
    loadingReport: true
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
    const report = window.powerbi.get(embedContainer)
    report.on('loaded', () => {
      this.loadingReport = false
    })
  }
}
</script>
<style scoped>
.content {
  display: flex;
  flex-flow: column;
  height: 100%;
}

#embed-container {
  flex-grow: 1;
}
</style>
