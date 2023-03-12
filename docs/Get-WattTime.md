---
external help file: PSWattTime-help.xml
Module Name: PSWattTime
online version: https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTime.md
schema: 2.0.0
---

# Get-WattTime

## SYNOPSIS
Query watttime.org for the current ba

## SYNTAX

```
Get-WattTime [-ba] <String> [-AuthToken] <String> [<CommonParameters>]
```

## DESCRIPTION
Query watttime.org for the current ba on the https://api2.watttime.org/index endpoint

## EXAMPLES

### EXAMPLE 1
```
Get-WattTime -ba 'NL' -AuthToken $authToken
```

## PARAMETERS

### -ba
The ba to query for

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

## NOTES
A ba is WattTime's term for a balancing authority.
A balancing authority is a regional entity that is responsible for maintaining the balance between supply and demand of electricity in a given region.
For more information, see https://www.watttime.org/faq

## RELATED LINKS

[https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTime.md](https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTime.md)

[https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeAuthToken.md](https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeAuthToken.md)

[https://www.watttime.org/api-documentation/#real-time-emissions-index](https://www.watttime.org/api-documentation/#real-time-emissions-index)

