---
external help file: PSWattTime-help.xml
Module Name: PSWattTime
online version:
schema: 2.0.0
---

# Get-AzureRegionWithLowestWattTime

## SYNOPSIS
Get the Azure region with the lowest wattTime index

## SYNTAX

```
Get-AzureRegionWithLowestWattTime [-Regions] <String[]> [-AuthToken] <String> [<CommonParameters>]
```

## DESCRIPTION
Get the current WattTime index for a given Azure Region

## EXAMPLES

### EXAMPLE 1
```
Get-AzureRegionWithLowestWattTime -Regions westeurope,northeurope -AuthToken $authToken
```

## PARAMETERS

### -Regions
The list of Azure Regions to get the WattTime index for

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthToken
The authentication token to use for the request

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject containing the following properties:
###     ba: The WattTime ba for the given Azure Region
###     percent: The current WattTime index for the given Azure Region
###     region: The Azure Region for which the WattTime index was retrieved
## NOTES

## RELATED LINKS
