Describe "PSWattTimeTests" {
    BeforeAll {
        $module = Import-Module -Name $PSScriptRoot/../../src/PSWattTime/PSWattTime.psd1 -PassThru
        $module | Should -Not -BeNullOrEmpty
        $env:WATTTIMEUSERNAME | Should -Not -BeNullOrEmpty
        $env:WATTTIMEPASSWORD | Should -Not -BeNullOrEmpty
    }

    Context "When we have imported the module" {
        It "Should have a ConvertFrom-AzureRegion command" {
            $test = Get-Command -Module PSWattTime -Name 'ConvertFrom-AzureRegion'
            $test | Should -Not -BeNullOrEmpty
            $test.CommandType | Should -Be 'Function'
        }

        It "Should have a Get-AzureRegionWithLowestWattTime command" {
            $test = Get-Command -Module PSWattTime -Name 'Get-AzureRegionWithLowestWattTime'
            $test | Should -Not -BeNullOrEmpty
            $test.CommandType | Should -Be 'Function'
        }

        It "Should have a Get-WattTime command" {
            $test = Get-Command -Module PSWattTime -Name 'Get-WattTime'
            $test | Should -Not -BeNullOrEmpty
            $test.CommandType | Should -Be 'Function'
        }

        It "Should have a Get-WattTimeAuthToken command" {
            $test = Get-Command -Module PSWattTime -Name 'Get-WattTimeAuthToken'
            $test | Should -Not -BeNullOrEmpty
            $test.CommandType | Should -Be 'Function'
        }

        It "Should have a Get-WattTimeForAzureRegion command" {
            $test = Get-Command -Module PSWattTime -Name 'Get-WattTimeForAzureRegion'
            $test | Should -Not -BeNullOrEmpty
            $test.CommandType | Should -Be 'Function'
        }

        It "Should have a New-WattTimeAccount command" {
            $test = Get-Command -Module PSWattTime -Name 'New-WattTimeAccount'
            $test | Should -Not -BeNullOrEmpty
            $test.CommandType | Should -Be 'Function'
        }

    }
    
    Context "When we login" {
        It "Should return a token" {
            $authToken = Get-WattTimeAuthToken -Username $env:WATTTIMEUSERNAME -Password $env:WATTTIMEPASSWORD
            $authToken | Should -Not -BeNullOrEmpty
        }
    }

    Context "When we convert an Azure region to a ba" {
        BeforeAll {
            $authToken = Get-WattTimeAuthToken -Username $env:WATTTIMEUSERNAME -Password $env:WATTTIMEPASSWORD
            $query = ConvertFrom-AzureRegion -Region 'westeurope' -AuthToken $authToken
        }

        It "Should not be empty" {
            $query | Should -Not -BeNullOrEmpty
        }

        It "Should return a ba" {
            $query | Should -Be 'NL'
        }
    }

    Context "When we get the WattTime for a region" {
        BeforeAll {
            $authToken = Get-WattTimeAuthToken -Username $env:WATTTIMEUSERNAME -Password $env:WATTTIMEPASSWORD
            $wattTime = Get-WattTimeForAzureRegion -Region 'westeurope' -AuthToken $authToken
        }

        It "Should not be empty" {
            $wattTime | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject" {
            $wattTime | Should -BeOfType 'PSCustomObject'
        }

        It "Should return a PSCustomObject with a ba property" {
            $wattTime.ba | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject with a ba property with a value" {
            $wattTime.ba | Should -Be 'NL'
        }

        It "Should return a PSCustomObject with a region property" {
            $wattTime.region | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject with a region property with a value" {
            $wattTime.region | Should -Be 'westeurope'
        }

        It "Should return a PSCustomObject with a percent property" {
            $wattTime.percent | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject with a percent property with a value" {
            $wattTime.percent | Should -BeOfType 'string'
        }
    }

    Context "When we get the WattTime for a list of regions" {
        BeforeAll {
            $authToken = Get-WattTimeAuthToken -Username $env:WATTTIMEUSERNAME -Password $env:WATTTIMEPASSWORD
            $wattTime = Get-AzureRegionWithLowestWattTime -Regions 'westeurope','northeurope' -AuthToken $authToken
        }

        It "Should not be empty" {
            $wattTime | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject" {
            $wattTime | Should -BeOfType 'PSCustomObject'
        }

        It "Should return a PSCustomObject with a ba property" {
            $wattTime.ba | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject with a ba property with a value" {
            $wattTime.ba | Should -BeOfType 'string'
        }

        It "Should return a PSCustomObject with a region property" {
            $wattTime.region | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject with a region property with a value" {
            $wattTime.region | Should -BeOfType 'string'
        }

        It "Should return a PSCustomObject with a percent property" {
            $wattTime.percent | Should -Not -BeNullOrEmpty
        }

        It "Should return a PSCustomObject with a percent property with a value" {
            $wattTime.percent | Should -BeOfType 'string'
        }
    }
    Context "When we register an account" {
        BeforeAll {
            Mock -ModuleName PSWattTime -CommandName Invoke-RestMethod { return (New-Object PSObject -Property @{'user' = 'freddo';'ok' = 'User created'})}
            $newAccount = New-WattTimeAccount `
                -Username 'freddo' `
                -Password 'P@ssvvordsAr3St00p1d' `
                -Organization 'CloudySpells' `
                -Email 'freddo@example.com'
        }
        
        It "Should return a PSObject" {
            $newAccount | Should -BeOfType 'PSObject'
        }

        It "Should return an ok field with a user created value" {
            $newAccount.ok | Should -Be 'User created'
        }
    }
}