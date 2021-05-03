# NOT OC - script from Alex Asplund
# this script requests an access token for the MS Graph API,
# then makes a simple request to fetch all security alerts for Azure

# Define AppId, secret and scope, tenant name and endpoint URL
$AppId = '026212a7-9609-44aa-9971-0d597cb18c6f'
$AppSecret = '5-Da4R6IyQIh2j6bdhlFK9_P-LDU.Prd6V'
$Scope = "https://graph.microsoft.com/.default"
$TenantName = "rochinsttech.onmicrosoft.com"
$Url = "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token"

# Add System.Web for urlencode
Add-Type -AssemblyName System.Web

# Create body
$Body = @{
    client_id = $AppId
	client_secret = $AppSecret
	scope = $Scope
	grant_type = 'client_credentials'
}

# Splat the parameters for Invoke-Restmethod for cleaner code
$PostSplat = @{
    ContentType = 'application/x-www-form-urlencoded'
    Method = 'POST'
    # Create string by joining bodylist with '&'
    Body = $Body
    Uri = $Url
}

# Request the token!
$Request = Invoke-RestMethod @PostSplat

# Create header
$Header = @{
    Authorization = "$($Request.token_type) $($Request.access_token)"
}

$Uri = "https://graph.microsoft.com/v1.0/security/alerts"

# Fetch all security alerts
$SecurityAlertsRequest = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get -ContentType "application/json"

# $SecurityAlerts = $SecurityAlertsRequest.Value
