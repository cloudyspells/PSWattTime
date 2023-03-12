---
external help file: PSWattTime-help.xml
Module Name: PSWattTime
online version: https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeAuthToken.md
schema: 2.0.0
---

# Get-WattTimeAuthToken

## SYNOPSIS
Get an authentication token for the WattTime API

## SYNTAX

```
Get-WattTimeAuthToken [-Username] <String> [-Password] <String> [<CommonParameters>]
```

## DESCRIPTION
Get an authentication token for the WattTime API with a specified username and password

## EXAMPLES

### EXAMPLE 1
```
Get-WattTimeAuthToken -Username 'username' -Password 'password'
```

## PARAMETERS

### -Username
The username to use for authentication

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

### -Password
The password to use for authentication

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

### a string containing the authentication token for the WattTime API
## NOTES
This token should be used by the -AuthToken parameter of the other functions in this module

## RELATED LINKS

[https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeAuthToken.md](https://github.com/cloudyspells/PSWattTime/blob/main/docs/Get-WattTimeAuthToken.md)

[https://www.watttime.org/api-documentation/#login-amp-obtain-token](https://www.watttime.org/api-documentation/#login-amp-obtain-token)

