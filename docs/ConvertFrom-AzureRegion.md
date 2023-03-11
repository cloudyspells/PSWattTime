---
external help file: PSWattTime-help.xml
Module Name: PSWattTime
online version:
schema: 2.0.0
---

# ConvertFrom-AzureRegion

## SYNOPSIS
Get a WattTime ba for a given Azure Region

## SYNTAX

```
ConvertFrom-AzureRegion [-Region] <String> [-AuthToken] <String> [<CommonParameters>]
```

## DESCRIPTION
Get a WattTime ba for a given Azure Region via the https://api2.watttime.org/v2/ba-from-loc endpoint

## EXAMPLES

### EXAMPLE 1
```
ConvertFrom-AzureRegion -Region westeurope
```

## PARAMETERS

### -Region
The Azure Region to get the WattTime ba for

```yaml
Type: String
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

### a string containing the WattTime ba for the given Azure Region
## NOTES
A ba is WattTime's term for a balancing authority.
A balancing authority is a regional entity that is responsible for maintaining the balance between supply and demand of electricity in a given region.
For more information, see https://www.watttime.org/faq

## RELATED LINKS
