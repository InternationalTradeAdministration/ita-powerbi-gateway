const axios = require('axios')

export async function getBearerToken() {
  const tokenResponse = await axios.get('/api/pbi-admin/get-access-token').then(response => response.data)
  localStorage.accessToken = tokenResponse.access_token
}

export async function listReports(workspaceName) {
  let groups = await pbiAdminListGroups('?$filter=name eq \'' + workspaceName + '\'')
  return pbiAdminListReports(groups[0].id, null)
}

export async function getReport(workspaceName, reportName) {
  let groups = await pbiAdminListGroups('?$filter=name eq \'' + workspaceName + '\'')
  let reports = await pbiAdminListReports(groups[0].id, '?$filter=name eq \'' + reportName + '\'')
  let report = await pbiAdminGetReport(groups[0].id, reports[0].id)
  let token = await pbiAdminGenerateToken(groups[0].id, reports[0].id)

  return {
    powerBiReport: report,
    powerBiToken: token
  }
}

export async function pbiAdminListGroups(filter) {
  let baseUrl = 'https://api.powerbigov.us/v1.0/myorg/groups'
  let url = (filter !== null) ? baseUrl + filter : baseUrl

  return await axios.get(url, {
    headers: buildHeaders()
  }).then(response => response.data.value);
}

async function pbiAdminGetReport(groupId, reportId) {
  return axios.get('https://api.powerbigov.us/v1.0/myorg/groups/' + groupId + '/reports/' + reportId, {
    headers: buildHeaders()
  }).then(response => response.data)
}

async function pbiAdminGenerateToken(groupId, reportId) {
  return axios.post('https://api.powerbigov.us/v1.0/myorg/groups/' + groupId + '/reports/' + reportId + '/GenerateToken', {
    accessLevel: 'View'
  },
    {
      headers: buildHeaders()
    }).then(response => response.data)
}


async function pbiAdminListReports(groupId, filter) {
  let baseUrl = 'https://api.powerbigov.us/v1.0/myorg/groups/' + groupId + '/reports'
  let url = (filter !== null) ? baseUrl + filter : baseUrl
  return axios.get(url, {
    headers: buildHeaders()
  }).then(response => response.data.value);
}

function buildHeaders() {
  return {
    Authorization: 'Bearer ' + localStorage.accessToken
  }
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

export async function getOtexaHts() {
  return await axios.get('/api/otexa/hts').then(response => response.data)
}