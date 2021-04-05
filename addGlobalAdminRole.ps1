# NOT OC - script from Microsoft docs
# this adds a new role to the specified user

$userName="sus@rochinsttech.onmicrosoft.com"
$roleName="Global Administrator"
$role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}

if ($role -eq $null) {
$roleTemplate = Get-AzureADDirectoryRoleTemplate | Where {$_.displayName -eq $roleName}
Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId
$role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}
}

Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId (Get-AzureADUser | Where {$_.UserPrincipalName -eq $userName}).ObjectID
