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
