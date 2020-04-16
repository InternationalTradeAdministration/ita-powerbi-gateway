[![Build Status](https://dev.azure.com/InternationalTradeAdministration/Data%20Services/_apis/build/status/Power%20BI%20Gateway%20-%20Dev2?branchName=master)](https://dev.azure.com/InternationalTradeAdministration/Data%20Services/_build/latest?definitionId=99&branchName=master)

# Power BI Gateway

An app that will publicly display Embedded Power BI reports on GovCloud using a service principle.
The following links can help configure Azure and Power BI:

- [Embed Setup](https://app.powerbigov.us/embedsetup/appownsdata)
- [Embed Service Principle](https://docs.microsoft.com/en-us/power-bi/developer/embed-service-principal)

## Local Development

### Deveoper Prerequisites

- .NET Core
- [NPM](https://www.npmjs.com/get-npm) (`cd client` then `npm install`)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Docker CLI](https://docs.docker.com/engine/reference/commandline/cli)
- [KUBECTL CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl) (if deploying to AKS)

### Backend

`node app.js`, <http://localhost:8080>

### Frontend

`cd client && npm run serve`, <http://localhost:8081>

## Build

- CI/CD build script ```./build.sh```

## Required Environment Variables

- TENANT_ID: Azure Tenant ID
- CLIENT_ID: Application ID from the AD App Registration
- CLIENT_SECRET: Client secret from the AD App Registration

For detail related to the deployment of containerized applications in Azure, reference this [repo](https://github.com/InternationalTradeAdministration/azure-samples) with deployment scenarios
