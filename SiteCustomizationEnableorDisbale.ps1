Import-Module Microsoft.Online.SharePoint.PowerShell
$username = "JP-NML-365-000004@nissangroup.onmicrosoft.com"
$password = "M365AdminPROD@020122"
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $Password -asplaintext -force)
#$siteURL = "https://nissangroup.sharepoint.com/teams/JAO_NS_000087_Testingafterpasswordchange"

Connect-SPOService -Url https://nissangroup-admin.sharepoint.com -credential $cred
#Enable
#Set-SPOSite -Identity $siteURL  -DenyAddAndCustomizePages 1
#Disaable
#Set-SPOSite -Identity $siteURL  -DenyAddAndCustomizePages 1
Get-SPOSite -Identity $siteURL  -Detailed | select DenyAddAndCustomizePages