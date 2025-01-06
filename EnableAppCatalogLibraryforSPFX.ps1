#Variables for processing
$AdminCenterURL = "https://sitename-admin.sharepoint.com"
 
#User Name Password to connect
$AdminUserName = ""
$AdminPassword = " " #App Password
 
#Prepare the Credentials
$SecurePassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
$Credential = new-object -typename System.Management.Automation.PSCredential -argumentlist $AdminUserName, $SecurePassword
  
#Connect to SharePoint Online
Connect-SPOService -url $AdminCenterURL  -credential $Credential
$siteURL = "https://sitename.sharepoint.com/teams/JAO_NML_Contract_repository"
$site = Get-SPOSite $siteURL
Add-SPOSiteCollectionAppCatalog -Site $site 