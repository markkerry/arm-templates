param appName string
param location string = resourceGroup().location

resource insights 'Microsoft.Insights/components@2015-05-01' = {
    name: 'insights-${appName}'
    location: location
    properties: {
        Application_Type: 'web'
    }
}

resource hosting 'Microsoft.web/serverfarms@2019-08-01' = {
    name: 'hosting-${appName}'
    location: location
    sku: {
        name: 'S1'
    }
}

resource app 'Microsoft.Web/sites@2018-11-01' = {
    name: appName
    location: location
    identity: {
        type: 'SystemAssigned'
    }
    properties: {
        name: appName
        siteConfig: {
            appSettings: [
                {
                    name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                    value: insights.properties.InstrumentationKey
                }
            ]
        }
        serverFarmId: hosting.id
    }
}

output appId string = app.id