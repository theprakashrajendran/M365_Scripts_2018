$username = " "
$password = " "
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $Password -asplaintext -force)
$TenantSiteUrl ="https://sitename-admin.sharepoint.com"
Import-Module "C:\FJ_O365_Operation\MSOnline\1.1.166.0\MSOnline.psd1"

#Connect-SPOService -Url $TenantSiteUrl -credential $Cred 
#$SiteURL = "https://sitename.sharepoint.com/teams/newsitecreatedPS"
 
#New-SPOSite -Url $SiteURL -Owner $username -StorageQuota 2000 -Title "newsitecreatedPS" -Template "STS#3" -LocaleID 1033 -NoWait 
#Get-SPOSite -Identity $SiteURL

Connect-MsolService -Credential $Cred
(Get-MsolUser -userprincipalName JP-NML-365-000012@nissangroup.onmicrosoft.com).PreferredDatalocation

 #Set-MsolUser -userprincipalName JP-NML-365-000012@nissangroup.onmicrosoft.com -PreferredDatalocation NAM

