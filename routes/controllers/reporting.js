const utils = require('../../services/utils.js')
const auth = require('../../services/authentication.js')

exports.listReports = async (req, res, next) => {
  const tokenResponse = await auth.getAuthenticationToken()
  const response = await utils.createListReportsRequest(tokenResponse.accessToken)
  return res.json(response)
}

exports.getReport = async (req, res, next) => {
  if (!req.query.reportId) {
    return res.json('Please pass a reportId on the query string')
  }

  const tokenResponse = await auth.getAuthenticationToken()
  const resonse = await utils.createReportRequest(tokenResponse.accessToken, req.query.reportId)
  return res.json(resonse)
}

exports.generateEmbedToken = async (req, res) => {
  if (!req.query.reportId) {
    return res.json('Please pass a reportId on the query string')
  }

  const tokenResponse = await auth.getAuthenticationToken()
  const response = await utils.createEmbedTokenRequest(tokenResponse.accessToken, req.query.reportId)
  return res.json(response.token)
}
