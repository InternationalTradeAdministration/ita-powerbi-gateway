# ITA Dataloader Reporting

An app that will publicly display Embedded Power BI reports on GovCloud using a service principle.
The following links can help configure Azure and Power BI:

- <https://app.powerbigov.us/embedsetup/appownsdata>
- <https://docs.microsoft.com/en-us/power-bi/developer/embed-service-principal>

## Local Development

### Deveoper Prerequisites

- .NET Core
- NPM

### Backend

`node app.js`, <http://localhost:8080>

### Frontend

`cd client && npm run serve`, <http://localhost:8081>

## Required Environment Variables

- TENANT_ID: Azure Tenant ID
- CLIENT_ID: Application ID from the AD App Registration
- CLIENT_SECRET: Client secret from the AD App Registration
- WORKSPACE_ID: Power BI Workspace ID / Group
