resource vnet 'Microsoft.Network/virtualNetworks@2018-10-01' = {
    name: 'vnet001'
    location: resourceGroup().location
    tags: {
        CostCenter: '12345'
        Owner: 'mark'
    }
    properties: {
        addressSpace: {
            addressPrefixes: [
                '10.0.0.0/15'
            ]
        }
        enableVmProtection: false
        enableDdosProtection: false
        subnets: [
            {
                name: 'subnet001'
                properties: {
                    addressPrefix: '10.0.0.0/24'
                }
            }
            {
                name: 'subnet002'
                properties: {
                    addressPrefix: '10.0.1.0/24'
                }
            }
        ]
    }
}