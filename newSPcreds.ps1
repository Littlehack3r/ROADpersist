# author - Julie McGlensey
# this script first creates a new self-signed certificate,
# then adds the new certificate to an existing service principal

$SPname = "changeMeToSPName"

$cert = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\My" `
  -Subject "CN=testCert" `
  -KeySpec KeyExchange

Get-AzADApplication -DisplayName $SPname | New-AzADAppCredential `
  -CertValue $keyValue `
  -EndDate $cert.NotAfter `
  -StartDate $cert.NotBefore