function test-module{

    Get-AzureADSubscribedSku

}

function adduser{
    param(  
        [Parameter(Mandatory = $true)][string]$passwd,
        [Parameter(Mandatory = $true)][string]$displayname,
        [Parameter(Mandatory = $true)][string]$nickname,
        [Parameter(Mandatory = $true)][string]$email
    )
    Process{
        $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
        $PasswordProfile.Password = "$passwd"

        $params = @{
            AccountEnabled = $true
            DisplayName = $displayname
            PasswordProfile = $PasswordProfile
            UserPrincipalName = $email
            MailNickName = $nickname
        }

        New-AzureADUser @params
    }
}