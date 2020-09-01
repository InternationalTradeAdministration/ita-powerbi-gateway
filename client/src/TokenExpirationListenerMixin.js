export default {
  methods: {
    setTokenExpirationListener(tokenExpiration, minutesToRefresh = 2) {
      let currentTime = Date.now()
      let expiration = Date.parse(tokenExpiration + 'Z')
      let safetyInterval = minutesToRefresh * 60 * 1000
      let timeout = expiration - currentTime - safetyInterval

      if (timeout <= 0) {
        this.updateToken()
      } else {
        setTimeout(() => {
          this.updateToken()
        }, timeout)
      }
    },
    updateToken() {
      let groupName = this.$route.params.workspaceName
      let reportName = this.$route.params.reportName
      this.repository.generateToken(groupName, reportName)
      .then(r => {
        let embedContainer = this.$refs['embed-container']
        let report = window.powerbi.get(embedContainer)
        report.setAccessToken(r.powerBiToken.token)
        this.setTokenExpirationListener(r.powerBiToken.expiration)
      })
    }
  }
}
