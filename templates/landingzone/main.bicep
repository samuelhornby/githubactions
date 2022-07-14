
@description('Enter the environment code, for example "dev" for development. This gets used in naming of all resources')
param environmentCode string
@description('Enter the Azure region code, for example "ae" for Australia East. This gets used in naming of all resources')
param azureRegionCode string
@description('Enter the Azure location to deploy all resources in this deployment to')
param location string

targetScope = 'subscription'

var applicationCode = 'mgmt'
var resourceGroupName = 'rg-${applicationCode}-${environmentCode}-${azureRegionCode}'
var storageAccountName = 'stglmsdiagnostics${environmentCode}${azureRegionCode}'

module mgmtResourceGroup '../modules/resourceGroup.bicep' = {
  name: resourceGroupName
  params: {
    location: location
    resourceGroupName: resourceGroupName
  }
}


module storageAccount '../modules/storageAccount.bicep' = {
  scope: resourceGroup(mgmtResourceGroup.name)
  name: storageAccountName
  params: {
    location: location
    storageAccountName: storageAccountName
  }
}
