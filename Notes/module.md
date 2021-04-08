# Steps to install
https://adamtheautomator.com/powershell-modules/#What_Makes_up_a_PowerShell_Module
1. find-module -repository localrepo  
2. Install-Module -Name ROADPersist -Repository LocalRepo
3. You also need to make sure you place this in the $env:PSModulePath and don’t have any other conflicting installs of your module.


# Add your powershell script

1. Change format to following:

```
Function Name { 
		[CmdletBinding()]
		Param( 
				[Parameter(Position = 0, Mandatory = $true)][String]$Message, 
				[Parameter(Position = 1, Mandatory = $true)][String]$Title, 
				[Parameter(Position = 2, Mandatory = $true)][String]$URI
		) 
		Process { 
				$Params = @{ 
						"URI" = 	$URI 
						"Method" = 	'POST' 
						"Body" = 	[PSCustomObject][Ordered]@{ 
									"@type" = 'MessageCard' 
									"@context" = 'http://schema.org/extension' 
									"summary" = $Title 
									"title" = $Title 
									"text" = ($Message | Out-String) 
								} 
						"ContentType" = 'application/json' 
						} 
				Invoke-RestMethod @Params | Out-Null 
		} 
	}

```
2. Update psd1
3. Publish-Module -Name .\ROADPersist -Repository LocalRepo    
4. update-module roadpersist
