const axios = require('axios')

export async function getGroups() {
  return axios.get('/api/list-groups').then(response => response.data);
}

export async function getReports(workspaceId) {
  return axios.get('/api/list-reports', {
    params: {
      workspaceId
    }
  }).then(response => response.data);
}

export async function getReportById(workspaceId, reportId) {
  return axios.get('/api/get-report-by-id', {
    params: {
      workspaceId, reportId
    }
  }).then(response => response.data)
}

export async function getReportByName(workspaceId, reportName) {
  return axios.post('/api/get-report-by-name', {
    reportName
  }, {
      params: {
        workspaceId
      }
    }).then(response => response.data)
}
