# author - Julie McGlensey
# this script adds a new certificate to an existing service principal

$cert = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\My" `
  -Subject "CN=certificateNameGoesHere" `
  -KeySpec KeyExchange
$keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())

Get-AzADServicePrincipal -DisplayName servicePrincipalNameGoesHere | New-AzADSpCredential `
  -CertValue $keyValue `
  -EndDate $cert.NotAfter `
  -StartDate $cert.NotBefore
