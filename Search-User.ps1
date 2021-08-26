<#Substituir os campos com "extensionAttribute1" para o campo onde é gravado o CPF do usuário no AD #>
function Search-User {
    param (
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet('cpf', 'name', 'samaccount')]
        [string]$InputType,
        [Parameter(Mandatory, Position = 1)]
        [string]$InputValue,
        [Parameter(Mandatory, Position = 2)]
        [ValidateSet('cpf', 'email', 'name', 'samaccount', 'enabled', 'dname','whenCreated','LastLogonDate','PasswordLastSet','whenChanged','tipo')]
        [string]$OutputType
    )
    function Get-User {
        param(
            [string]$type
        )
        $email = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties mail | Select-Object -ExpandProperty mail
        $user = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties SamAccountName | Select-Object -ExpandProperty SamAccountName
        $cpf = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties extensionAttribute1 | Select-Object -ExpandProperty extensionAttribute1
        $name = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties cn | Select-Object -ExpandProperty cn
        $enabled = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties Enabled | Select-Object -ExpandProperty Enabled
        $dname = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties distinguishedname | Select-Object -ExpandProperty distinguishedname
        $whenCreated = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties whenCreated | Select-Object -ExpandProperty whenCreated
        $LastLogonDate = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties LastLogonDate | Select-Object -ExpandProperty LastLogonDate
        $PasswordLastSet = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties PasswordLastSet | Select-Object -ExpandProperty PasswordLastSet
        $whenChanged = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties whenChanged | Select-Object -ExpandProperty whenChanged
        $tipo = Get-ADUser -LDAPFilter "($type=$InputValue)" -Properties extensionAttribute3 | Select-Object -ExpandProperty extensionAttribute3
        if ($OutputType -eq 'email') { return $email }
        elseif ($OutputType -eq 'samaccount') { return $user }
        elseif ($OutputType -eq 'cpf') { return $cpf }
        elseif ($OutputType -eq 'name') { return $name }
        elseif ($OutputType -eq 'enabled') { return $enabled }
        elseif ($OutputType -eq 'dname') { return $dname }
        elseif ($OutputType -eq 'whenCreated') { return $whenCreated }
        elseif ($OutputType -eq 'LastLogonDate') { return $LastLogonDate }
        elseif ($OutputType -eq 'PasswordLastSet') { return $PasswordLastSet }
        elseif ($OutputType -eq 'whenChanged') { return $whenChanged }
        elseif ($OutputType -eq 'tipo') { return $tipo }
        else { "" }
    }
    if ($InputType -eq 'name') {
        Get-User -type "cn"
    }
    elseif ($InputType -eq 'samaccount') {
        Get-User -type "SamAccountName"
    }
    else {
        Get-User -type "extensionAttribute1"
    }
}
