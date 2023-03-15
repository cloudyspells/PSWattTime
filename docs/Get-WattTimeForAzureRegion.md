# Get-WattTimeForAzureRegion

## SYNOPSIS
Get the current WattTime index for a given Azure Region

## SYNTAX

```
Get-WattTimeForAzureRegion [-Region] <String> [-AuthToken] <String> [<CommonParameters>]
```

## DESCRIPTION
Get the current WattTime index for a given Azure Region

## EXAMPLES

### EXAMPLE 1
```
Get-WattTimeForAzureRegion -Region westeurope -AuthToken $authToken
```

## PARAMETERS

### -Region
The Azure Region to get the WattTime index for

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
The WattTime API authentication token to use for the request

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
### - ba: The WattTime ba for the given Azure Region
### - percent: The current WattTime index for the given Azure Region
### - region: The Azure Region for which the WattTime index was retrieved
## NOTES
This command, like the module, requires you to be connected to Azure via Connect-AzAccount

## RELATED LINKS

[https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeForAzureRegion.md](https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeForAzureRegion.md)

[https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTime.md](https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTime.md)

[https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeAuthToken.md](https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeAuthToken.md)

