Describe "PSWattTimeTests" {
    BeforeAll {
        $module = Import-Module -Name $PSScriptRoot/../../src/PSWattTime/PSWattTime.psd1 -PassThru
        $module | Should -Not -BeNullOrEmpty
        $env:WATTTIMEUSERNAME | Should -Not -BeNullOrEmpty
        $env:WATTTIMEPASSWORD | Should -Not -BeNullOrEmpty
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
}