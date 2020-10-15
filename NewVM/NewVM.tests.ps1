Describe 'ARM Template Validation' {

    BeforeAll {
        $TemplatePath = "C:\Git\repos\Arm\NewVM\NewVM.json"
        $templateRaw = Get-Content -Path $TemplatePath -Raw -ErrorAction SilentlyContinue
        $template = ConvertFrom-Json -InputObject $templateRaw -ErrorAction SilentlyContinue
    }

    Context 'File Validation' {
        It 'Template ARM file exists' {
            Test-Path $TemplatePath -Include "*.json" | Should -Be $true
        }
        It 'Is a valid JSON file' {
            $templateRaw | ConvertFrom-Json -ErrorAction SilentlyContinue | Should -Not -Be $null
        }
    }

    Context 'Template Content Validation' {
        It 'Contains all required elements' {
            $elements = '$schema',
                        'contentVersion',
                        'functions',
                        'outputs',
                        'parameters',
                        'resources',
                        'variables'
            $templateElements = $template | Get-Member -MemberType NoteProperty | ForEach-Object Name
            $templateElements | Should -Be $elements
        }
        It 'Creates the expected resources' {
            $resources = 'Microsoft.Storage/storageAccounts',
                        'Microsoft.Network/publicIPAddresses',
                        'Microsoft.Network/networkSecurityGroups',
                        'Microsoft.Network/virtualNetworks',
                        'Microsoft.Network/networkInterfaces',
                        'Microsoft.Compute/virtualMachines'
            $templateResources = $template.resources.type
            $templateResources | Should -Be $resources
        }
    }
}