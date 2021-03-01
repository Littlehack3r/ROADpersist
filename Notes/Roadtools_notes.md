[[Capstone]]

- RT = ROADTools
- RR = ROADRecon
- 
A framework that consist of two main components:
1. a library Roadlib
2. The ROADrecon Azure AD exploration tool

# Roadlib
- a library used to authenticate with Azure AD
- can be used to build tools that integrate with a database containing ROADrecon data
    - database model is automatically generated based on the metadata definition of the azure AD internal API
- import syntax ``from roadtools.roadlib import X`

## Roadlib Abilities  
1.  handles Authentication
2.  handles Metadata 
    a.  knows how Azure stores its data
3.  Azure AD scheme definitions 

# ROADrecon
-   Uses an automatically generated metadata model to create an SQLAlchemy backed database on disk
-   Use asynchronous HTTP calls in Python to dump all available information in the Azure AD graph to this database
    -   development is done with Python 3.8
-   Provide plugins to query this database and output it to a useful format.
-   Provide an extensive interface built in Angular that queries the offline database directly for its analysis


## ROADrecon Process
1.  Data gathering
2.  Data exploration or conversion


### Authentication
- username/password
    - `roadrecon auth -u user@mytenant.onmicrosoft.com -p Passwordhere`
    -  - A POST request containing username + pass + appID sent to the endpoint for authentication 
            - Does not support MFA 
            - The response contains 3 tokens 
                - Access Token - used to access Azure AD Graph API 
                    - Valid for 1hr
                - Refresh Token - used to request new access token 
                    - Default valid for 9 days. can be changed.
                - ID Token - for the application verification (not relevant)
- Device code flow
    - a code that can be used on the Microsoft login page in your web browser to sign in interactively
    - Prompts for MFA
    - Flow: User authenticates on website --> Application gets an authorization code --> Authorization code can be exchanged for session + refresh token
        - For web apps (w/ backend) a secret is required
        - For public clients (e.x. native apps) no secret is required 
    - To start this flow, `--device-code`
- [Using a PRT cookie](https://github.com/dirkjanm/ROADtools/wiki/Getting-started-with-ROADrecon#using-a-prt-cookie)
    - SSO authentication
    - requires RCE on a target that is Azure AD joined/registered or Hybrid joined
    - usage `--prt-init`


### Data gathering
- After the authentication process the resulting tokens will be written to `.roadtools_auth`
- the command `readrecon gather` is used to collect all data 


### Data exploration or conversion
- After data collection. Data is saved offline in the database file `roadrecon.db`
- the command `roadrecon gui` is used to lunch the GUI for data processing 



### [Plugins](https://github.com/dirkjanm/ROADtools/wiki/Getting-started-with-ROADrecon#using-the-data)
- policies
    - Parse conditional access policies and export those to a file called `caps.html`
- [bloodhound](https://github.com/dirkjanm/BloodHound-AzureAD)
    - Export Azure AD data to a custom BloodHound version
    
    

# General Notes
- RT interacts with Azure AD through Azure AD Graph 
    - No documentation 
- Application authentication Process
    - spoofs App ID to another application that is registered
        - can only have the same permissions as the application used
        - AzureAD PS module is an OAuth2 public client (no verification)
            - Other applications can be used if the have the `user_immpersonation` permission enabled
                - e.x: `Microsoft.MileIQ`, `SharePoint Online Client Extensibility`, `Microsoft Teams - Device Admin Agent`, `Microsoft Stream Mobile Native`, `SharePoint Online Client`, `Outlook Oline Add-in App`
    - OAuth2 password grant flow
        - A.K.A Resource Owner Password Credentials (ROPC) Grant
       
            - 