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

## Build

- CI/CD build script ```./build.sh```

## Required Environment Variables

- TENANT_ID: Azure Tenant ID
- CLIENT_ID: Application ID from the AD App Registration
- CLIENT_SECRET: Client secret from the AD App Registration
- WORKSPACE_ID: Power BI Workspace ID / Group

## AKS Deployment

**Prerequisites*

- Azure CLI <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>
- Docker CLI <https://docs.docker.com/engine/reference/commandline/cli/>
- KUBECTL CLI (if deploying to AKS) <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
- Azure Subscription
- Azure Container Registry (ACR)
- Azure Kubernetes Service (AKS)
- A Static IP Address in Azure confiured with a DNS Name
- An AKS Ingess Controller with TLS
- Additional documentaion: <https://docs.microsoft.com/en-us/azure/aks/ingress-static-ip>

### Scripts & Configuration Files

1. Log in with the Azure CLI: ```az login```
1. Select the appropriate Subscription. Ex: ```az account set --subscription "Sample_Subscription"```
1. Get credentials. Ex: ````az aks get-credentials --resource-group my-resources --name myAKS --overwrite-existing````
1. Rename ```kube-config-template.yml``` to ```kube-config.yml``` and update it with the following:
    - image locations
    - namespace for each section
    - host names in the Ingress section
1. Update ```deploy-aks.sh``` with the appropriate Azure Container Registry and Azure Container Key
1. Execute ```deploy-aks.sh```
1. For Azure DevOps pipeline configuration, update: ```azure-pipelines.yml```

The application will be available at the following URL: [<http://ip-dns-name.location.cloudapp.azure.com>]
The location in the URL will be the location of the Kubernetes cluster. Ex: eastus, centralus, etc...
