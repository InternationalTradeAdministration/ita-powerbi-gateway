const config = require('../config/config.js')
const adal = require('adal-node')

async function getAuthenticationToken () {
  var AuthenticationContext = adal.AuthenticationContext

  turnOnLogging()

  var authorityUrl = config.params.authorityUrl.replace('common', config.params.tenantId)
  var context = new AuthenticationContext(authorityUrl)

  return new Promise(
    (resolve, reject) => {
      context.acquireTokenWithClientCredentials(
        config.params.resourceUrl,
        config.params.clientId,
        config.params.clientSecret,
        function (err, tokenResponse) {
          if (err) reject(err)
          resolve(tokenResponse)
        })
    })
}

function turnOnLogging () {
  var log = adal.Logging
  log.setLoggingOptions(
    {
      level: log.LOGGING_LEVEL.VERBOSE,
      log: function (level, message, error) {
        console.log(message)
        if (error) console.log(error)
      }
    })
}

module.exports.getAuthenticationToken = getAuthenticationToken
