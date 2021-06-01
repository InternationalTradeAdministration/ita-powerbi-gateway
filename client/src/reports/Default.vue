<template>
  <div class="content">
    <span v-if="loading">loading...</span>
    <toolbar v-else :loadingReport="loadingReport" :pbi="pbi" :repository="repository" />
    <div id="embed-container" ref="embed-container"></div>
  </div>
</template>
<script>
import Toolbar from '@/Toolbar'
import TokenExpirationListenerMixin from "../TokenExpirationListenerMixin"
export default {
  name: 'Default',
  props: ['repository', 'pbi'],
  components: {
    'toolbar': Toolbar
  },
  mixins: [TokenExpirationListenerMixin],
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
      permissions: this.pbi.models.Permissions.All,
      settings: {
        panes: {
          filters: {
            visible: this.$route.query.filtersVisible !== 'false'
          },
          pageNavigation: {
            visible: this.$route.query.pageNavigationVisible !== 'false'
          }
        }
      }
    }

    let embedContainer = this.$refs['embed-container']
    window.powerbi.embed(embedContainer, embedConfig)
    const report = window.powerbi.get(embedContainer)
    report.on('loaded', () => {
      this.loadingReport = false
      this.setTokenExpirationListener(r.powerBiToken.expiration)
      embedContainer.children[0].style.height = null;
    })
  }
}
</script>
