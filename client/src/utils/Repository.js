const axios = require('axios')

export default class Repository {
  async getBearerToken() {
    const expiresOn = localStorage.expiresOn;
    if (!expiresOn || (expiresOn && (Date.now() / 1000) > expiresOn)) {
      const tokenResponse = await axios.get('/api/pbi-admin/get-access-token').then(response => response.data)
      localStorage.expiresOn = tokenResponse.expires_on
      localStorage.accessToken = tokenResponse.access_token
    }
  }
  
  async listReports(workspaceName) {
    let groups = await this.pbiAdminListGroups('?$filter=name eq \'' + workspaceName + '\'')
    return this.pbiAdminListReports(groups[0].id, null)
  }

  async getReport(workspaceName, reportName) {
    let groups = await this.pbiAdminListGroups('?$filter=name eq \'' + workspaceName + '\'')
    let reports = await this.pbiAdminListReports(groups[0].id, '?$filter=name eq \'' + reportName + '\'')
    let report = await this.pbiAdminGetReport(groups[0].id, reports[0].id)
    let token = await this.pbiAdminGenerateToken(groups[0].id, reports[0].id)
  
    return {
      powerBiReport: report,
      powerBiToken: token
    }
  }
  
  async pbiAdminListGroups(filter) {
    let baseUrl = 'https://api.powerbigov.us/v1.0/myorg/groups'
    let url = (filter !== null) ? baseUrl + filter : baseUrl
  
    return await axios.get(url, {
      headers: this.buildHeaders()
    }).then(response => response.data.value);
  }
  
  pbiAdminGetReport(groupId, reportId) {
    return axios.get('https://api.powerbigov.us/v1.0/myorg/groups/' + groupId + '/reports/' + reportId, {
      headers: this.buildHeaders()
    }).then(response => response.data)
  }
  
  pbiAdminGenerateToken(groupId, reportId) {
    return axios.post('https://api.powerbigov.us/v1.0/myorg/groups/' + groupId + '/reports/' + reportId + '/GenerateToken', {
      accessLevel: 'View'
    },
      {
        headers: this.buildHeaders()
      }).then(response => response.data)
  }
  
  
  pbiAdminListReports(groupId, filter) {
    let baseUrl = 'https://api.powerbigov.us/v1.0/myorg/groups/' + groupId + '/reports'
    let url = (filter !== null) ? baseUrl + filter : baseUrl
    return axios.get(url, {
      headers: this.buildHeaders()
    }).then(response => response.data.value);
  }
  
  buildHeaders() {
    return {
      Authorization: 'Bearer ' + localStorage.accessToken
    }
  }
  
  async getOtexaCountries() {
    return await axios.get('/api/otexa/countries').then(response => response.data)
  }
  
  async getOtexaCategories() {
    return await axios.get('/api/otexa/categories').then(response => response.data)
  }
  
  async getOtexaChapters() {
    return await axios.get('/api/otexa/chapters').then(response => response.data)
  }
  
  async getOtexaHts(categoryIds, chapterIds) {
    return await axios.get('/api/otexa/hts?categories=' + categoryIds + '&chapters=' + chapterIds).then(response => response.data)
  }

}
