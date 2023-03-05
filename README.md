PSWattTime
==========

PowerShell Module for getting PSWattTime emission data
------------------------------------------------------

[![PowerShell Module Quality Assurance](https://github.com/cloudyspells/PSWattTime/actions/workflows/qa.yml/badge.svg)](https://github.com/cloudyspells/PSWattTime/actions/workflows/qa.yml)

This PowerShell module is intended for retrieving emissions
data from [WattTime]('https://www.watttime.org/') for a
supplied Azure Region.

This module is supplied as-is at the moment and not (yet)
published through _PSGallery_.

### Usage

To get started with this module you will need an account on
[WattTime]('https://www.watttime.org/'). See 
[the manual]('https://www.watttime.org/api-documentation/#register-new-user')
on registering an account. NOTE: You can only register via the API.
Currently no GUI exists for registration. 

You will also need the _Az.Resources_ PowerShell Module for Azure installed
and connected to your Azure account. See 
[the installation manual]('https://learn.microsoft.com/en-us/powershell/azure/install-az-ps') for the _Az_ module for instructions.


Import the module from a clone of this repository:

```
Import-Module .\src\PSWattTime
```

Authenticate to the _WattTime_ API:

```
 $token = Get-WattTimeAuthToken -Username '<YOUR_WATTTIME_USERNAME>' -Password '<YOUR_WATTTIME_PASSWORD>'
```

Get current percentage of energy with emissions the 'westeurope' Azure region:

```
PS C:\> Get-WattTimeForAzureRegion -Region westeurope -AuthToken $token

ba         : NL
freq       : 300
percent    : 94
point_time : 5-3-2023 13:15:00
region     : westeurope

```

Determine the lowest emissions for the list of northeurope,
westeurope, francecentral and uksouth Azure regions:

```
PS C:\> Get-AzureRegionWithLowestWattTime -Regions westeurope,uksouth,northeurope,francecentral -AuthToken $token

ba         : IE
freq       : 300
percent    : 69
point_time : 5-3-2023 14:15:00
region     : northeurope

```
