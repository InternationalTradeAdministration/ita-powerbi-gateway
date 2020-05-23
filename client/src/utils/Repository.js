const axios = require('axios')

export default class Repository {
  async listGroups() {
    return await axios.get("/api/pbi-admin/groups").then(response => response.data.value)
  }

  async listReports(workspaceName) {
    return await axios.get("/api/pbi-admin/reports", {
      params: {
        workspaceName
      }
    }).then(response => response.data.value)
  }

  async generateToken(workspaceName, reportName) {
    return await axios.get("/api/pbi-admin/generate-token", {
      params: {
        workspaceName, reportName
      }
    }).then(response => response.data)
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
