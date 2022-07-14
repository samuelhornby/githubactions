@description('Provide the location to deploy the resource to')
param location string = 'australiaeast'
@description('Name of the resource group')
param resourceGroupName string

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  properties: {
  }
}
