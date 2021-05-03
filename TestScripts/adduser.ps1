$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "YiIzf#f4f96ewIsrfCZ6#"

$params = @{
    AccountEnabled = $true
    DisplayName = "Suspect"
    PasswordProfile = $PasswordProfile
    UserPrincipalName = "sus@rochinsttech.onmicrosoft.com"
    MailNickName = "Sus"
}

New-AzureADUser @params



