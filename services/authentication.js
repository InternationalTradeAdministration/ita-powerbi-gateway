var config = require('../config/config.js');

async function getAuthenticationToken() {
    var adal = require('adal-node');
    var AuthenticationContext = adal.AuthenticationContext;

    function turnOnLogging() {
        var log = adal.Logging;
        log.setLoggingOptions(
            {
                level: log.LOGGING_LEVEL.VERBOSE,
                log: function (level, message, error) {
                    console.log(message);
                    if (error) {
                        console.log(error);
                    }
                }
            });
    }

    turnOnLogging();

    var authorityUrl = config.params.authorityUrl.replace('common', config.params.tenantId)
    var context = new AuthenticationContext(authorityUrl);
    let promise = () => {
        return new Promise(
            (resolve, reject) => {
                context.acquireTokenWithClientCredentials(config.params.resourceUrl, config.params.clientId, config.params.clientSecret, function (err, tokenResponse) {
                    if (err) reject(err);
                    resolve(tokenResponse);
                })
            });
    };

    var res;
    await promise().then(
        tokenResponse => res = tokenResponse
    ).catch(
        err => res = err
    );

    return res;
}

module.exports.getAuthenticationToken = getAuthenticationToken;