const request = require('request')
const config = require('../config/config.js')
const guid = require('guid')

function validateConfig () {
  if (!config.params.tenantId) {
    return 'TenantId is empty. please register your application as Native app in https://dev.powerbi.com/apps and fill client Id in config.js'
  }

  if (!guid.isGuid(config.params.tenantId)) {
    return 'TenantId must be a Guid object. please register your application as Native app in https://dev.powerbi.com/apps and fill application Id in config.js'
  }

  if (!config.params.clientSecret) {
    return 'ClientSecret is empty. please register your application as Native app in https://dev.powerbi.com/apps and fill client Id in config.js'
  }

  if (!config.params.clientId) {
    return 'ClientId is empty. please register your application as Native app in https://dev.powerbi.com/apps and fill client Id in config.js'
  }

  if (!guid.isGuid(config.params.clientId)) {
    return 'ClientId must be a Guid object. please register your application as Native app in https://dev.powerbi.com/apps and fill application Id in config.js'
  }

  if (!config.params.workspaceId) {
    return 'WorkspaceId is empty. Please select a group you own and fill its Id in config.js'
  }

  if (!guid.isGuid(config.params.workspaceId)) {
    return 'WorkspaceId must be a Guid object. Please select a workspace you own and fill its Id in config.js'
  }

  if (!config.params.authorityUrl) {
    return 'AuthorityUrl is empty. Please fill valid AuthorityUrl under config.js'
  }
}

async function createReportRequest (accessToken, reportId) {
  const url = config.params.apiUrl + 'v1.0/myorg/groups/' + config.params.workspaceId + '/reports/' + reportId
  const requestParmas = buildHttpRequestParameters(url, accessToken, 'GET')
  return sendRequest(requestParmas)
}

async function createListReportsRequest (accessToken) {
  const url = config.params.apiUrl + 'v1.0/myorg/groups/' + config.params.workspaceId + '/reports'
  const requestParmas = buildHttpRequestParameters(url, accessToken, 'GET')
  return sendRequest(requestParmas)
}

async function createEmbedTokenRequest (accessToken, reportId) {
  const url = config.params.apiUrl + 'v1.0/myorg/groups/' + config.params.workspaceId + '/reports/' + reportId + '/GenerateToken'
  const requestParmas = buildHttpRequestParameters(url, accessToken, 'POST', JSON.stringify({ accessLevel: 'View' }))
  return sendRequest(requestParmas)
}

function buildHttpRequestParameters (url, accessToken, method, body) {
  return {
    url,
    options: {
      method,
      body,
      headers: {
        Authorization: 'Bearer '.concat(accessToken),
        'Content-Type': 'application/json'
      }
    }
  }
}

async function sendRequest (requestParmas) {
  return new Promise(
    (resolve, reject) => {
      request(requestParmas.url, requestParmas.options, function (error, response, body) {
        if (error) {
          reject(error)
        } else {
          resolve(JSON.parse(body))
        }
      })
    })
}

module.exports = {
  validateConfig: validateConfig,
  createReportRequest: createReportRequest,
  createListReportsRequest: createListReportsRequest,
  createEmbedTokenRequest: createEmbedTokenRequest
}
