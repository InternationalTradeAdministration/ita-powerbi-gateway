const utils = require('../../services/utils.js')
const auth = require('../../services/authentication.js')

exports.listGroups = async (req, res, next) => {
  const tokenResponse = await auth.getAuthenticationToken()
  const groups = await utils.listGroups(tokenResponse.accessToken)
  return res.json(groups.value)
}

exports.listReports = async (req, res, next) => {
  if (!req.body.workspaceName) {
    return res.json('Please pass a workspaceName in the body of the request')
  }

  const tokenResponse = await auth.getAuthenticationToken()
  const groups = await utils.listGroups(tokenResponse.accessToken, buildFilter(req.body.workspaceName))
  const workspaceId = groups.value[0].id
  const reports = await utils.listReports(tokenResponse.accessToken, workspaceId)
  return res.json(reports.value)
}

exports.getReport = async (req, res) => {
  if (!req.body.workspaceName) {
    return res.json('Please pass a workspaceName in the body of the request')
  }

  if (!req.body.reportName) {
    return res.json('Please pass a reportName in the body of the request')
  }

  const accessToken = await auth.getAuthenticationToken().then(response => response.accessToken)

  const groups = await utils.listGroups(accessToken, buildFilter(req.body.workspaceName))
  const workspaceId = groups.value[0].id

  const reports = await utils.listReports(accessToken, workspaceId, buildFilter(req.body.reportName))
  const reportId = reports.value[0].id

  const report = await utils.getReport(accessToken, workspaceId, reportId)
  const embedTokenReposnse = await utils.getEmbedToken(accessToken, workspaceId, reportId)
  report.embedToken = embedTokenReposnse.token

  return res.json(report)
}

function buildFilter(name) {
  return "?$filter=name%20eq%20'" + name + "'"
}