const axios = require('axios')

export async function getBearerToken() {
  const tokenResponse = await axios.get('/api/pbi-admin/get-access-token').then(response => response.data)
  localStorage.accessToken = tokenResponse.access_token
}

export async function listGroups() {
  return axios.get('/api/pbi-admin/list-groups', {
    params: {
      accessToken: localStorage.accessToken
    }
  }).then(response => response.data);
}

export async function listReports(workspaceName) {
  let groups = await listGroups()
  let groupId = groups.find(g => g.name == workspaceName).id

  return axios.get('/api/pbi-admin/list-reports', {
    params: {
      groupId,
      accessToken: localStorage.accessToken
    }
  }).then(response => response.data);
}

export async function getReport(workspaceName, reportName) {
  let groups = await listGroups(workspaceName)
  let groupId = groups.find(g => g.name == workspaceName).id

  let reports = await listReports(workspaceName)
  let reportId = reports.find(r => r.name == reportName).id

  return axios.get('/api/pbi-admin/get-report', {
    params: {
      groupId,
      reportId,
      accessToken: localStorage.accessToken
    }
  }).then(response => response.data)
}

export async function getOtexaCountries() {
  return await axios.get('/api/otexa/countries').then(response => response.data)
}

export async function getOtexaCategories() {
  return await axios.get('/api/otexa/categories').then(response => response.data)
}

export async function getOtexaChapters() {
  return await axios.get('/api/otexa/chapters').then(response => response.data)
}