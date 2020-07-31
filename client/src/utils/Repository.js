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

  async getOtexaCountries(source) {
    return await axios.get('/api/otexa/countries',  {
      params: {
        source
      }
    }).then(response => response.data)
  }

  async getOtexaCategories(source) {
    return await axios.get('/api/otexa/categories', {
      params: {
        source
      }
    }).then(response => response.data)
  }

  async getOtexaChapters() {
    return await axios.get('/api/otexa/chapters').then(response => response.data)
  }

  async getOtexaHts(categoryIds, chapterIds) {
    return await axios.get('/api/otexa/hts?categories=' + categoryIds + '&chapters=' + chapterIds).then(response => response.data)
  }

  exportToFile(workspaceName, reportName, bookmarkState) {
    return axios.get("/api/pbi-admin/export-to-file", {
      params: {
        workspaceName, reportName, bookmarkState
      }
    }).then(response => response.data)
  }

  getExportToFileStatus(workspaceName, reportName, exportStatusId) {
    return axios.get("/api/pbi-admin/export-to-file-status", {
      params: {
        workspaceName, reportName, exportStatusId
      }
    }).then(response => response.data)
  }

  async getExportFile(workspaceName, reportName, exportStatusId) {
    return await axios.get("/api/pbi-admin/export-file", {
      params: {
        workspaceName, reportName, exportStatusId
      }
    }).then(response => response.data)
  }
}
