# author - Becca Fried
# This script assigns a role to a user

# hard coded option
# New-AzureADMSRoleAssignment -SignInName rebecca@rochinsttech.onmicrosoft.com -RoleDefinitionName "Reader" -Scope "/subscriptions/8f17be46-ec06-4fcb-aa25-12acefc27780/resourceGroups/resourceGroup1"

# other option
$signIn = Read-Host -Prompt "Enter the desired email"
$roleDefName = Read-Host -Prompt "Enter the role name"
New-AzureADMSRoleAssignment -SignInName $signIn -RoleDefinitionName $roleDefName -Scope "/subscriptions/8f17be46-ec06-4fcb-aa25-12acefc27780/resourceGroups/resourceGroup1"