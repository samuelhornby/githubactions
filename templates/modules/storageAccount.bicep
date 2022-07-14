@description('Provide the location to deploy the resource to')
param location string = resourceGroup().location
@description('Enter the name of the storage account')
param storageAccountName string = 'parallodemost'
@description('Enter the name of the SKU to deploy for this storage account')
param storageAccountSkuName string = 'Standard_LRS'
@description('Allow storage account access using connection string')
param allowSharedKeyAccess bool = false

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSkuName
  }
  properties: {
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    allowSharedKeyAccess: allowSharedKeyAccess
    minimumTlsVersion: 'TLS1_2'
    isHnsEnabled: false
    allowCrossTenantReplication: true
    accessTier: 'Hot'
    publicNetworkAccess: 'Enabled'
    routingPreference: {
      routingChoice: 'InternetRouting'
    }
    encryption: {
      keySource: 'Microsoft.Storage'	
      requireInfrastructureEncryption: true
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
      }
    }
  }
}


output saResourceId string = storageAccount.id 
output saResource object = storageAccount
