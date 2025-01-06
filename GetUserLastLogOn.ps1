param ([string]$StartDate, [string]$EndDate, [string]$UserName, [string]$password, [string]$UPNEmail)
#[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
#Import-Module "C:\Users\scs01054\AppData\Local\Apps\SharePointPnPPowerShellOnline\Modules\SharePointPnPPowerShellOnline\SharePointPnP.PowerShell.Online.Commands.dll" 

Try {
$sPassword = ConvertTo-SecureString $password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $sPassword)


$proxysettings = New-PSSessionOption -ProxyAccessType IEConfig
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication "Basic" -AllowRedirection -SessionOption $proxysettings -WarningAction SilentlyContinue -InformationAction SilentlyContinue -OutVariable $out
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential 
 Import-PSSession $Session -AllowClobber

$Operations = @('UserLoggedIn')

$logs = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate  -ResultSize 1   -Operations $Operations  -UserIds $UPNEmail
$RecordCnt = ($logs).count
$ConvertAudit = $logs | Select-Object -ExpandProperty AuditData | ConvertFrom-Json
$customObject = $ConvertAudit | Select-Object -Property CreationTime 
#Write-host ($logs).count
$sLasLoginDate = "";
cls
if(($customObject.CreationTime).count -gt 0)
{
    $sLasLoginDate =$customObject.CreationTime

    Write-host "CreatedTime##@@##"$sLasLoginDate
}
else
{
    $sLasLoginDate = "NoValue" 
    Write-host $sLasLoginDate 
}

   
# $connection = Connect-PnPOnline -Url $RequestSiteURL -Credentials $Credential -ErrorAction SilentlyContinue 
# Write-host "sLasLoginDate : " $sLasLoginDate 
# $out = Set-PnPListItem -List "Admin_account" -Identity $sID -Values @{"Comment" = $sLasLoginDate; }
#Disconnect-PnPOnline -Connection $connection
# Disconnect-PSSession -Id $Session.Id  
#Disconnect-AzureAD
}

Catch {

    Write-Host "Error:" $_.Exception.Message`n

}

#.\GetUserLastLogOn.ps1 "2015/03/20" "2020/03/20" "collaboration_tool_batch_account@jpqanissangroup.onmicrosoft.com" "Nissan2020Mar" "ac-migration@jpqanissangroup.onmicrosoft.com"
# C:\\Prakash\\Powershell\\GetUserLastLogOn.ps1 2015/03/20 2020/03/20 collaboration_tool_batch_account@jpqanissangroup.onmicrosoft.com Nissan2020Mar ac-migration@jpqanissangroup.onmicrosoft.com
#.\LastLogin.ps1c
