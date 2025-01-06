Import-Module Microsoft.Online.SharePoint.PowerShell
$siteURL = "https://"
$username = ""
$password = ""
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $Password -asplaintext -force)
Connect-SPOService -Url https://nissangroup-admin.sharepoint.com -credential $cred
Get-SPOSite  $siteURL | Select Owner 
