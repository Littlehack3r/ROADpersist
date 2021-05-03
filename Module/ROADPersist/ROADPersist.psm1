
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

function newSPcreds {
		Param( 
				[Parameter(Mandatory = $true)][String]$spName, 
				[Parameter(Mandatory = $true)][String]$certName
		) 
		Process { 
				$cert = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\My" `
                  -Subject "CN=${certName}" `
                  -KeySpec KeyExchange
                $keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())

                Get-AzADServicePrincipal -DisplayName $spName | New-AzADSpCredential `
                  -CertValue $keyValue `
                  -EndDate $cert.NotAfter `
                  -StartDate $cert.NotBefore
		}
}

function addrole{
    param(  
        [Parameter(Mandatory = $true)][string]$SignInName,
        [Parameter(Mandatory = $true)][string]$roleDefName,
        [Parameter(Mandatory = $true)][string]$subId,
        [Parameter(Mandatory = $true)][string]$resourceGroupName
    )
    Process{

        New-AzRoleAssignment -SignInName $SignInName -RoleDefinitionName $roleDefName -Scope "/subscriptions/$subId/resourceGroups/$resourceGroupName"

    }
}
