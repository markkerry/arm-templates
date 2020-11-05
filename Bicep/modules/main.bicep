module stg './storage.bicep' = {
    name: 'storageDeploy'
    params: {
        namePrefix: 'conprd'
    }
}
output storageName string = stg.outputs.computedStorageName