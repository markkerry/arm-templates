# arm-templates

## Bicep - ARM DSL

Create a .bicep file

``` powershell
New-Item -Path . -Name storageAccount.bicep -ItemType "File"
```

 To compile it, modify it and to save changes

``` terminal
bicep build storageAccount.bicep
```

Deploy it

``` powershell
Connect-AzAccount
New-AzResourceGroup -Name MyRG -Location westeurope
New-AzResourceGroupDeployment -TemplateFile ./storageAccount.json -ResourceGroupName MyRG
```

Or Azure CLI

``` python
az login
az group create -n MyRG -l westeurope
az deployment group create -f ./storageAccount.json -g MyRG
```

## How a template is converted to Rest API operation

When you create an arm json file such as the following:

```json
"resources": [
  {
    "type": "Microsoft.Storage/storageAccounts",
    "apiVersion": "2019-04-01",
    "name": "mystorageaccount",
    "location": "westus",
    "sku": {
      "name": "Standard_LRS"
    },
    "kind": "StorageV2",
    "properties": {}
  }
]
```

When you deploy it, it converts the definition to the following REST API operation, which is sent to the Microsoft.Storage resource provider:

```http
PUT
https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/mystorageaccount?api-version=2019-04-01
REQUEST BODY
{
  "location": "westus",
  "sku": {
    "name": "Standard_LRS"
  },
  "kind": "StorageV2",
  "properties": {}
}
```