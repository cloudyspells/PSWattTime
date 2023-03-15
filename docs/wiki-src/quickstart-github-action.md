Getting started with PSWattTime
===============================

Steps for using the GitHub Action
---------------------------------

This PowerShell module also comes with a _GitHub Action_ you can use
in your GitHub workflows. Again you will need a pre-existing account
for _WattTime_ and an Azure CLI/PowerShell secret configured in your repo

### Example

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

      - name: Get region with lowest emissions
        uses: cloudyspells/PSWattTime@v1.0.4
        id: watttime_action # Set step id for using output in deployment
        with:
          azure_credential: ${{ secrets.AZURE_CREDENTIALS }}
          watttime_username: ${{ secrets.WATTTIMEUSERNAME }}
          watttime_password: ${{ secrets.WATTTIMEPASSWORD }}
          regions: '"westeurope","northeurope","uksouth","francecentral","germanynorth"'

      - name: Login to Az PowerShell Module
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
          enable-AzPSSession: true

      - uses: azure/arm-deploy@v1
        name: Run Bicep deployment
        with:
          subscriptionId: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
          scope: subscription
          region: ${{ steps.watttime_action.outputs.region }} # The region output from PSWattTime
          template: src/bicep/main.bicep
```
