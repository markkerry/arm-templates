# Validate what will change with the WhatIf param
New-AzResourceGroupDeployment -Name "NewVM" -ResourceGroupName "rg-mk-bicep" -TemplateParameterFile .\NewVM.parameters.json -TemplateFile .\NewVM.json -WhatIf

# Deploy via incremental mode
New-AzResourceGroupDeployment -Name "NewVM" -ResourceGroupName "rg-mk-bicep" -TemplateParameterFile .\NewVM.parameters.json -TemplateFile .\NewVM.json 

# The -mode Complete param will remove anything in the RG which isn't defined in the template
New-AzResourceGroupDeployment -Name "NewVM" -ResourceGroupName "rg-mk-bicep" -TemplateParameterFile .\NewVM.parameters.json -TemplateFile .\NewVM.json -Mode Complete