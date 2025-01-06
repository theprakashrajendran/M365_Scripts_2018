Import-Module Microsoft.Online.SharePoint.PowerShell
$siteURL = "https://nissangroup-my.sharepoint.com/personal/ma-tsuda_mail_nissan_co_jp"
$username = "JP-NML-365-000004@nissangroup.onmicrosoft.com"
$password = "M365Jap@nAdmin@1021"
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $Password -asplaintext -force)
Connect-SPOService -Url https://nissangroup-admin.sharepoint.com -credential $cred
Get-SPOSite  $siteURL | Select Owner 