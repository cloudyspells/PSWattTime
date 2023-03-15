Getting started with PSWattTime
===============================

Steps for using the module in PowerShell
----------------------------------------

To get started with this module you will need an account on
[WattTime](https://www.watttime.org/). See
[the manual](https://www.watttime.org/api-documentation/#register-new-user)
on registering an account. The module provides a function `New-WattTimeAccount`
to create an account if you do not yet have one.

You will also need the _Az.Resources_ PowerShell Module for Azure installed
and connected to your Azure account. See
[the installation manual](https://learn.microsoft.com/en-us/powershell/azure/install-az-ps)
for the _Az_ module for instructions.

To install the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/PSWattTime/).

```powershell
Install-Module -Name PSWattTime
```

To register an account with _WattTime_:

```powershell
New-WattTimeAccount -Username <YOUR_USERNAME> `
  -Password '<YOUR_PASSWORD>' `
  -Email '<you@domain.com>' `
  -Organization <YOUR_ORGANIZATION>
```


Authenticate to the _WattTime_ API:

```powershell
 $token = Get-WattTimeAuthToken -Username '<YOUR_WATTTIME_USERNAME>' `
  -Password '<YOUR_WATTTIME_PASSWORD>'
```

Get current percentage of energy with emissions the 'westeurope' Azure region:

```powershell
PS C:\> Get-WattTimeForAzureRegion -Region westeurope -AuthToken $token

ba         : NL
freq       : 300
percent    : 94
point_time : 5-3-2023 13:15:00
region     : westeurope

```

Determine the lowest emissions for the list of northeurope,
westeurope, francecentral and uksouth Azure regions:

```powershell
PS C:\> Get-AzureRegionWithLowestWattTime -Regions westeurope,uksouth,northeurope,francecentral -AuthToken $token

ba         : IE
freq       : 300
percent    : 69
point_time : 5-3-2023 14:15:00
region     : northeurope

```

### Module Functions

- [ConvertFrom-AzureRegion](docs/ConvertFrom-AzureRegion.md)
- [Get-AzureRegionWithLowestWattTime](docs/Get-AzureRegionWithLowestWattTime.md)
- [Get-WattTime](docs/Get-WattTime.md)
- [Get-WattTimeAuthToken](docs/Get-WattTimeAuthToken.md)
- [Get-WattTimeForAzureRegion](docs/Get-WattTimeForAzureRegion.md)
- [New-WattTimeAccount](docs/New-WattTimeAccount.md)
