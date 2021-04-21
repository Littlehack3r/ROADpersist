# author - Julie McGlensey
# this script adds a new certificate to an existing service principal

$spName = Read-Host -Prompt 'Input the service principal display name to add credentials to'
$certName = Read-Host -Prompt 'Input the certificate name you want to be added'

$cert = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\My" `
  -Subject "CN=${certName}" `
  -KeySpec KeyExchange
$keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())

Get-AzADServicePrincipal -DisplayName $spName | New-AzADSpCredential `
  -CertValue $keyValue `
  -EndDate $cert.NotAfter `
  -StartDate $cert.NotBefore
