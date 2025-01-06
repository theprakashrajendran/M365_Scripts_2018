
param ([string]$TenantAdminSiteURL, [string]$GroupTitle, [string]$GroupName, [int]$LanguageCodeEng,[string]$UserName,[string]$password )
#[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
#Import-Module "C:\Users\scs01054\AppData\Local\Apps\SharePointPnPPowerShellOnline\Modules\SharePointPnPPowerShellOnline\SharePointPnP.PowerShell.Online.Commands.dll"  -warningaction "SilentlyContinue"

$sPassword = ConvertTo-SecureString $password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $sPassword)

Connect-PnPOnline -Url $TenantAdminSiteURL -Credentials $Credential -ErrorAction SilentlyContinue
Try
{
write-host @TenantAdminSiteURL
write-host @GroupTitle
write-host @GroupName
write-host @GroupDescription

New-PnPSite -Type TeamSite -Title $GroupTitle -Alias $GroupName  -Lcid $LanguageCodeEng

Write-Host "Success :Success"
}
catch {
    write-host "Error: $($_.Exception.Message)" 
}