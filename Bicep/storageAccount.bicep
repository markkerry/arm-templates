// Expose the resource location, name prefix and redundancy via parameters
param location string = resourceGroup().location
param namePrefix string = 'stg'
param globalRedundancy bool = true

// Add variables for storing values or complex expressions
var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}' // prefix is concatinated with the unique string function

// Add our first resource to our bicep file -- a basic storage account.
resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
    name: storageAccountName
    location: location
    kind: 'Storage'
    sku: {
        name: globalRedundancy ? 'Standard_GRS' : 'Stardard_LRS' // reference variable and use a ternary operator. True is Standard_GRS. Means do not need to use if/else.
    }
}

// Create a blob container, dependsOn will be added to the template when compliled
resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
    name: '${stg.name}/default/logs'
}

// Emit outputs to be passed to a script or another template
output storageId string = stg.id // output resourceId of storage account
output computedStorageName string = stg.name
output blobEndpoint string = stg.properties.primaryendpoint.blob