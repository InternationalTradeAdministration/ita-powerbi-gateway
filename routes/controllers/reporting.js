const utils = require('../../services/utils.js')
const auth = require('../../services/authentication.js')

exports.listReports = async (req, res, next) => {
  const tokenResponse = await auth.getAuthenticationToken()
  const response = await utils.createListReportsRequest(tokenResponse.accessToken)
  return res.json(response.value)
}

exports.getReportById = async (req, res, next) => {
  if (!req.query.reportId) {
    return res.json('Please pass a reportId on the query string')
  }

  const tokenResponse = await auth.getAuthenticationToken()
  const response = await utils.createReportRequest(tokenResponse.accessToken, req.query.reportId)
  const embedTokenReposnse = await utils.createEmbedTokenRequest(tokenResponse.accessToken, req.query.reportId)
  response.embedToken = embedTokenReposnse.token
  return res.json(response)
}

exports.getReportByName = async (req, res) => {
  if (!req.body.reportName) {
    return res.json('Please pass a reportName in the body of the request')
  }

  const tokenResponse = await auth.getAuthenticationToken()
  const reports = await utils.createListReportsRequest(tokenResponse.accessToken)
  const report = reports.value.find(r => r.name === req.body.reportName)
  const response = await utils.createReportRequest(tokenResponse.accessToken, report.id)
  const embedTokenReposnse = await utils.createEmbedTokenRequest(tokenResponse.accessToken, report.id)
  response.embedToken = embedTokenReposnse.token
  return res.json(response)
}
