<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <div v-else class="toolbar">
      <button class="toolbar-btn">
        <img src="/images/download.svg" @click="exportData" />
      </button>
      <button class="toolbar-btn">
        <img src="/images/fullscreen.svg" @click="fullscreen" />
      </button>
    </div>
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
    },
    async exportData () {
      let embedContainer = this.$refs['embed-container']
      const report = window.powerbi.get(embedContainer)
      const pages = await report.getPages()
      const firstPage = pages[0]
      const visuals = await firstPage.getVisuals()
      const firstVisual = visuals[0]
      const visualData = await firstVisual.exportData(
        this.pbi.models.ExportDataType.Summarized
      )
      var encodedUri =
        'data:text/csv;charset=utf-8,' + encodeURI(visualData.data)
      var link = document.createElement('a')
      link.setAttribute('href', encodedUri)
      link.setAttribute('download', 'data.csv')
      document.body.appendChild(link)
      link.click()
    }
  }
}
</script>
<style scoped>
.content {
  display: flex;
  flex-flow: column;
  height: 100%;
}

.toolbar {
  background-color: #eaeaea;
  height: 36px;
  display: flex;
  justify-content: flex-end;
}

.toolbar-btn {
  border: none;
  background: none;
  cursor: pointer;
  padding: 8px;
}

.toolbar-btn:hover {
  background-color: white;
}

#embed-container {
  flex-grow: 1;
}
</style>
