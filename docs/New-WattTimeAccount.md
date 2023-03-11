---
external help file: PSWattTime-help.xml
Module Name: PSWattTime
online version:
schema: 2.0.0
---

# New-WattTimeAccount

## SYNOPSIS
Create a new WattTime account

## SYNTAX

```
New-WattTimeAccount [-Username] <String> [-Password] <String> [-Email] <String> [-Organization] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new PSWattTime account with the specified username,
password, email and organization

## EXAMPLES

### EXAMPLE 1
```
New-WattTimeAccount -Username 'username' -Password 'password' -Email 'email' -Organization 'organization'
```

## PARAMETERS

### -Username
The username for the new account

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
The password for the new account

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

### -Email
The email address for the new account

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Organization
The organization for the new account

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject containing the following properties:
###     username: The username for the new account
###     email: The email address for the new account
###     org: The organization for the new account
###     token: The authentication token for the new account
## NOTES

## RELATED LINKS
