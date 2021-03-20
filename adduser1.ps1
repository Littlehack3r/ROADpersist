
$p = $args[0]
$dn = $args[1]
$nn = $args[2]
$pn = $args[3]

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = $p

$params = @{
    AccountEnabled = $true
    DisplayName = $dn
    PasswordProfile = $PasswordProfile
    UserPrincipalName = $pn
    MailNickName = $nn
}

New-AzureADUser @params



