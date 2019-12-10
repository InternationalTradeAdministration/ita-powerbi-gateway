# ITA Dataloader Reporting
A app that will display Power BI Embedded reports

## Local Development

**Prerequisites** 
 - .NET Core
 - NPM

**Backend** 
 - `node app.js`, http://localhost:8080

 **Frontend** 
 - `cd client && npm run serve`, http://localhost:8081

## Required Environment Variables
  - APP_ID: Application ID from the AD App Registration
  - WORKSPACE_ID: Power BI Workspace ID / Group
  - RPT_USERNAME: Username of a user with admin privlages to the Power BI Workspace / Group
  - RPT_PASSWORD: Password of the user
  