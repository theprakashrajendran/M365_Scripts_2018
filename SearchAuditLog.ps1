param ([string]$SiteURL, [string]$StartDate, [string]$EndDate, [string]$TodayDate, [string]$SiteId, [string]$SiteName, [string]$UserName, [string]$password)
#[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
#Import-Module "C:\Users\scs01054\AppData\Local\Apps\SharePointPnPPowerShellOnline\Modules\SharePointPnPPowerShellOnline\SharePointPnP.PowerShell.Online.Commands.dll" 
Try {
$RequestSiteURL = "https://nissangroup.sharepoint.com/sites/Request_site"
$sPassword = ConvertTo-SecureString $password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $sPassword)
#$Credential = New-Object typeName "System.Management.Automation.PSCredential" argumentList $username, $password


$SiteId = $SiteId  -replace "#@#@", "-" 
$SiteName = $SiteName  -replace "#@#@", " "


#$RportFolder - refer the folder location where the Auditlog is to be stored.
$ReportFolder = "C:\BatchJobs\NMLAuditLog\Report\"

$proxysettings = New-PSSessionOption -ProxyAccessType IEConfig
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication "Basic" -AllowRedirection -SessionOption $proxysettings
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential 
Import-PSSession $Session -AllowClobber
Write-host "*****************Audit Log Report Generation Started*****************"  -ForegroundColor Green




[array]$Sites = @($SiteId)

$FileName =  "AuditLog_Search"+".csv"

#$TodayDate = (Get-Date).ToString("yyyyMMdd")
$fso = new-object -ComObject scripting.filesystemobject
#$fso.CreateFolder($ReportFolder + $TodayDate)
$ReportPath  = $ReportFolder + $TodayDate +"\"+ $SiteName 

#$fso.CreateFolder($ReportPath)

$ReportFile =$ReportPath +"\"+ $FileName

Write-Host "Report Generation Startdate : " $sStartDate " EndDate : "$EndDate   -ForegroundColor Green


Write-Host "Extracting the Audit log for the time period "  $StartDate" - " $EndDate

do{	
$SyoriCnt = $SyoriCnt + 1
 
Write-Host "Started :" $SyoriCnt

$logs = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -ResultSize 5000 -SiteIds $SiteId


$RecordCnt = ($logs).count

$ConvertAudit = $logs | Select-Object -ExpandProperty AuditData | ConvertFrom-Json

$SAudtiFileMovedOperation = $ConvertAudit | Select-Object Operation

$ConvertAudit | Select-Object CreationTime,UserId,Operation,Workload,ObjectID,SourceFileName,SourceRelativeUrl,DestinationFileName,DestinationRelativeUrl | Export-Csv  $ReportFile -Encoding UTF8 -NoTypeInformation -Append


} while ( $RecordCnt -eq 5000 )

#Connect-PnPOnline -Url $RequestSiteURL -Credentials $Credential -ErrorAction SilentlyContinue
#Set-PnPListItem -List "AccessLogRequest" -Identity 15 -Values @{"IsAuditLog" = "No"; "BatchJobComments"="AuditLog Batch Completed, AccessLog Batch Need to Execute"}

Write-Host "Report Generation Completed " $StartDate " EndDate : "$EndDate -ForegroundColor DarkGreen
Write-Host "The output file is the location $ReportFile" -ForegroundColor DarkGreen
}

Catch {

    Write-Host "Error:" $_.Exception.Message`n

}



# .\SearchAuditLog.ps1 "https://jpqanissangroup.sharepoint.com/sites/Request_site/" "2019/10/01"  "2020/02/02" "20200221"

#.\SearchAuditLog.ps1 "https://jpqanissangroup.sharepoint.com/teams/JAO_NS_000021_SitePolicyTestingforMSTicket" "2020/02/01"  "2020/02/22" "20200222"