# Power BI Public (Gateway)

[![Build Status](https://dev.azure.com/InternationalTradeAdministration/Data%20Services/_apis/build/status/Power%20BI%20Gateway%20-%20Dev2?branchName=master)](https://dev.azure.com/InternationalTradeAdministration/Data%20Services/_build/latest?definitionId=99&branchName=master)

An app that will publicly display Embedded Power BI reports on GovCloud using a service principle.
The following links can help configure Azure and Power BI:

- [Embed Setup](https://app.powerbigov.us/embedsetup/appownsdata)
- [Embed Service Principle](https://docs.microsoft.com/en-us/power-bi/developer/embed-service-principal)

## Local Development

Steps to run this application on your local machine for development purposes.

### Deveoper Prerequisites

- Java 14
- [NPM](https://www.npmjs.com/get-npm) (`cd client` then `npm install`)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Docker CLI](https://docs.docker.com/engine/reference/commandline/cli)
- [KUBECTL CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl) (if deploying to AKS)

#### Running Locally

- Backend: `gradle bootRun`, [](http://localhost:8080)
- Frontend: `cd client && npm start`, [](http://localhost:8081)

## Build Scripts

- Application: `./build.sh`
- Container: `./build-push-docker-image.sh`

### Required Environment Variables

- TENANT_ID: Azure Tenant ID
- CLIENT_ID: Application ID from the AD App Registration
- CLIENT_SECRET: Client secret from the AD App Registration
- FLYWAY_URL: The jdbc connection to a AZURE SQL Database
- FLYWAY_USER: Username to the AZURE SQL Database
- FLYWAY_PASSWORD: Password to the AZURE SQL Database

For detail related to the deployment of containerized applications in Azure, reference this [repo](https://github.com/InternationalTradeAdministration/azure-samples) with deployment scenarios

## Database Notes

- SQL Scripts for updating the Database can be found here:  /src/main/resources/db/migration
