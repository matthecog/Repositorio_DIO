az extension add --name containerapp --upgrade

az provider register --namespace Microsoft.App

az provider register --namespace Microsoft.OperationalInsights


myRG=LAB003
myLocation=eastus
myAppContainerName=mycontainerapp-env-001

az group create --name LAB003 --location eastus

az containerapp env create --name mycontainerapp-env-001 --resource-group LAB003 --location eastus

az containerapp create \
 --name my-container-app \
 --resource-group LAB003 \
 --environment mycontainerapp-env-001 \
 --image mcr.microsoft.com/azuredocs/containerapps-helloworld:latest \
 --target-port 80 \
 --ingress 'external' \
 --query properties.configuration.ingress.fqdn