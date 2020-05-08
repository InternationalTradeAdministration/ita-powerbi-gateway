const axios = require('axios')

export async function getGroups() {
  return axios.get('/api/list-groups').then(response => response.data);
}

export async function listReports(workspaceName) {
  return axios.post('/api/list-reports', {
    workspaceName
  }).then(response => response.data);
}

export async function getReport(workspaceName, reportName) {
  return axios.post('/api/get-report', {
    workspaceName,
    reportName
  }).then(response => response.data)
}
