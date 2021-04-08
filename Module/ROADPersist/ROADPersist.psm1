function test-module{

    Get-AzureADSubscribedSku

}

function adduser{
    param(  
        [Parameter(Mandatory = $true)][string]$p,
        [Parameter(Mandatory = $true)][string]$dn,
        [Parameter(Mandatory = $true)][string]$nn,
        [Parameter(Mandatory = $true)][string]$pn
    )
    Process{
        $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
        $PasswordProfile.Password = "$p"

        $params = @{
            AccountEnabled = $true
            DisplayName = $dn
            PasswordProfile = $PasswordProfile
            UserPrincipalName = $pn
            MailNickName = $nn
        }

        New-AzureADUser @params
    }
}