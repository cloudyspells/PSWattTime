$script:azLocations = Get-AzLocation

<#
    .SYNOPSIS
    Get an authentication token for the WattTime API

    .DESCRIPTION
    Get an authentication token for the WattTime API with a specified username and password

    .PARAMETER Username
    The username to use for authentication

    .PARAMETER Password
    The password to use for authentication

    .EXAMPLE
    Get-WattTimeAuthToken -Username 'username' -Password 'password'
#>
function Get-WattTimeAuthToken {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Username,
        [Parameter(Mandatory=$true)]
        [string]$Password
    )
    $base64UsernamePassword = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$($Username):$($Password)"))
    $basicAuthValue = "Basic $base64UsernamePassword"
    $headers = @{
        'Authorization' = $basicAuthValue
    }

    $authToken = Invoke-RestMethod -Uri 'https://api2.watttime.org/v2/login' -Method Get -Headers $headers -ContentType 'application/json'
    return $authToken.token
}

<#
    .SYNOPSIS
    Query watttime.org for the current ba

    .DESCRIPTION
    Query watttime.org for the current ba on the https://api2.watttime.org/index endpoint

    .PARAMETER AuthToken
    The authentication token to use for the request

    .PARAMETER ba
    The ba to query for

    .EXAMPLE
    Get-WattTime -ba 'NL' -AuthToken $authToken
#>
function Get-WattTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ba,
        [Parameter(Mandatory=$true)]
        [string]$AuthToken
    )
    # call the WattTime API with GET request with the parameters
    $headers = @{
        'Authorization' = "Bearer $AuthToken"
    }
    $params = @{
        ba = $ba
    }
    $wattTime = Invoke-RestMethod -Uri 'https://api2.watttime.org/v2/index/' -Method Get -Headers $headers -Body $params -ContentType 'application/json'
    return $wattTime
}

<#
    .SYNOPSIS
    Get a WattTime ba for a given Azure Region

    .DESCRIPTION
    Get a WattTime ba for a given Azure Region via the https://api2.watttime.org/v2/ba-from-loc endpoint

    .PARAMETER Region
    The Azure Region to get the WattTime ba for

    .PARAMETER AuthToken
    The authentication token to use for the request

    .EXAMPLE
    ConvertFrom-AzureRegion -Region westeurope
#>
function ConvertFrom-AzureRegion {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Region,
        [Parameter(Mandatory=$true)]
        [string]$AuthToken
    )
    $azLocation = $azLocations | Where-Object { $_.Location -eq $Region }
    $headers = @{
        'Authorization' = "Bearer $AuthToken"
    }
    $params = @{
        latitude = $azLocation.Latitude
        longitude = $azLocation.Longitude
    }
    $wattTimeBa = Invoke-RestMethod -Uri 'https://api2.watttime.org/v2/ba-from-loc/' -Method Get -Headers $headers -Body $params -ContentType 'application/json'
    return $wattTimeBa.abbrev
}

<#
    .SYNOPSIS
    Get the current WattTime index for a given Azure Region

    .DESCRIPTION
    Get the current WattTime index for a given Azure Region

    .PARAMETER Region
    The Azure Region to get the WattTime index for

    .PARAMETER AuthToken
    The authentication token to use for the request

    .EXAMPLE
    Get-WattTimeForAzureRegion -Region westeurope -AuthToken $authToken
#>
function Get-WattTimeForAzureRegion {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Region,
        [Parameter(Mandatory=$true)]
        [string]$AuthToken
    )
    $wattTimeBa = ConvertFrom-AzureRegion -Region $Region -AuthToken $AuthToken
    $wattTime = Get-WattTime -ba $wattTimeBa -AuthToken $AuthToken
    $wattTime | Add-Member -MemberType NoteProperty -Name 'region' -Value $Region
    return $wattTime
}

<#
    .SYNOPSIS
    Get the Azure region with the lowest wattTime index

    .DESCRIPTION
    Get the current WattTime index for a given Azure Region

    .PARAMETER Regions
    The list of Azure Regions to get the WattTime index for

    .PARAMETER AuthToken
    The authentication token to use for the request

    .EXAMPLE
    Get-AzureRegionWithLowestWattTime -Regions westeurope,northeurope -AuthToken $authToken
#>
function Get-AzureRegionWithLowestWattTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Regions,
        [Parameter(Mandatory=$true)]
        [string]$AuthToken
    )
    $wattTime = @()
    foreach ($region in $Regions) {
        $wattTime += Get-WattTimeForAzureRegion -Region $region -AuthToken $AuthToken
    }
    $wattTime | Sort-Object -Property percent | Select-Object -First 1
}

<#
    .SYNOPSIS
    Create a new WattTime account

    .DESCRIPTION
    Creates a new PSWattTime account with the specified username,
    password, email and organization

    .PARAMETER Username
    The username for the new account

    .PARAMETER Password
    The password for the new account

    .PARAMETER Email
    The email address for the new account

    .PARAMETER Organization
    The organization for the new account

    .EXAMPLE
    New-WattTimeAccount -Username 'username' -Password 'password' -Email 'email' -Organization 'organization'
#>
function New-WattTimeAccount {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Username,
        [Parameter(Mandatory=$true)]
        [string]$Password,
        [Parameter(Mandatory=$true)]
        [string]$Email,
        [Parameter(Mandatory=$true)]
        [string]$Organization
    )
    $headers = @{
        'Content-Type' = 'application/json'
    }
    $body = @{
        username = $Username
        password = $Password
        email = $Email
        org = $Organization
    }
    $bodyJson = $body | ConvertTo-Json
    $response = Invoke-RestMethod -Uri 'https://api2.watttime.org/v2/register/' -Method Post -Headers $headers -Body $bodyJson -ContentType 'application/json'
    return $response
}

Export-ModuleMember -Function `
    Get-WattTimeAuthToken, `
    Get-WattTime, `
    ConvertFrom-AzureRegion, `
    Get-WattTimeForAzureRegion, `
    Get-AzureRegionWithLowestWattTime, `
    New-WattTimeAccount