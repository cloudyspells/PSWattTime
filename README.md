PSWattTime
==========

PowerShell Module for getting PSWattTime emission data
------------------------------------------------------

[![PowerShell Module Quality Assurance](https://github.com/cloudyspells/PSWattTime/actions/workflows/qa.yml/badge.svg)](https://github.com/cloudyspells/PSWattTime/actions/workflows/qa.yml)

This PowerShell module is intended for retrieving emissions
data from [WattTime](https://www.watttime.org/) for a
supplied Azure Region.

This module is supplied as-is at the moment and not (yet)
published through _PSGallery_.

### Usage

#### PowerShell Module

To get started with this module you will need an account on
[WattTime](https://www.watttime.org/). See 
[the manual](https://www.watttime.org/api-documentation/#register-new-user)
on registering an account. NOTE: You can only register via the API.
Currently no GUI exists for registration. 

You will also need the _Az.Resources_ PowerShell Module for Azure installed
and connected to your Azure account. See 
[the installation manual](https://learn.microsoft.com/en-us/powershell/azure/install-az-ps) for the _Az_ module for instructions.


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

#### GitHub Action

This PowerShell module also comes with a _GitHub Action_ you can use
in your GitHub workflows. Again you will need a pre-existing account
for _WattTime_ and an Azure CLI/PowerShell secret configured in your repo

**Example**

```yaml

on:
  pull_request:
    branches:
      - 'main'
      - 'releases/**'

name: Deploy to region with lowest emissions

jobs:
  deploy-to-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Login to Az PowerShell Module
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
          enable-AzPSSession: true

      - name: Get region with lowest emissions
        uses: cloudyspells/PSWattTime@main
        id: watttime_action
        with:
          azure_credential: ${{ secrets.AZURE_CREDENTIALS }}
          watttime_username: ${{ secrets.WATTTIMEUSERNAME }}
          watttime_password: ${{ secrets.WATTTIMEPASSWORD }}
          regions: '"westeurope","northeurope","uksouth","francecentral","germanynorth"'

      - uses: azure/arm-deploy@v1
        name: Run Bicep deployment
        with:
          subscriptionId: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
          scope: subscription
          region: ${{ steps.watttime_action.outputs.region }}
          template: src/bicep/main.bicep
```
