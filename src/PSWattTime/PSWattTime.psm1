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

    .NOTES
    This token should be used by the -AuthToken parameter of the other functions in this module

    .OUTPUTS
    a string containing the authentication token for the WattTime API
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

    .NOTES
    A ba is WattTime's term for a balancing authority. A balancing authority is a regional entity that is responsible for maintaining the balance between supply and demand of electricity in a given region. For more information, see https://www.watttime.org/faq

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

    .NOTES
    A ba is WattTime's term for a balancing authority. A balancing authority is a regional entity that is responsible for maintaining the balance between supply and demand of electricity in a given region. For more information, see https://www.watttime.org/faq

    .OUTPUTS
    a string containing the WattTime ba for the given Azure Region
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

    .OUTPUTS
    System.Management.Automation.PSObject containing the following properties:
        ba: The WattTime ba for the given Azure Region
        percent: The current WattTime index for the given Azure Region
        region: The Azure Region for which the WattTime index was retrieved
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

    .OUTPUTS
    System.Management.Automation.PSObject containing the following properties:
        ba: The WattTime ba for the given Azure Region
        percent: The current WattTime index for the given Azure Region
        region: The Azure Region for which the WattTime index was retrieved
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

    .OUTPUTS
    System.Management.Automation.PSObject containing the following properties:
        username: The username for the new account
        email: The email address for the new account
        org: The organization for the new account
        token: The authentication token for the new account
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