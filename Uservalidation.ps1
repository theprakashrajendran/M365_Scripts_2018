param ([string]$userName, [string]$password,[string]$UPNEmail)
Import-Module "C:\BatchJobs\Modules\AzureAD\2.0.0.155\AzureAD"
$sPassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($userName, $sPassword)

Try {
$connect = Connect-AzureAD -Credential $cred 
#$UserDetails = Get-AzureADUser | Where {$_.UserPrincipalName -eq $UPNEmail} 
#Write-Host "UserDetails: "$UserDetails.AccountEnabled 
cls
$UserDetails = Get-AzureADUser -ObjectId  $UPNEmail | Select-Object AccountEnabled
 
 if($UserDetails.AccountEnabled -eq $true)
 {
 Write-Host "Valid" 
 }

 if($UserDetails.AccountEnabled -eq $false)
 {
 Write-Host "Disabled" 
 }
 Disconnect-AzureAD
}


Catch {
if($_.Exception.Message -contains "*does not exist or one of its queried reference-property objects are not present")
{
    Write-Host "InValid" 
}
else
{
    Write-Host "Error:" $_.Exception.Message`n
}
}
#.\Uservalidation.ps1 "collaboration_tool_batch_account@jpqanissangroup.onmicrosoft.com" "Nissan2020Mar" "EasticaAdmin-365@jpqanissangroup.onmicrosoft.com"
#C:\Prakash\000_Office365\BatchDevelopment\NML.AccountDeActivation\SourceCode\NML.AccountDeActivation
#.\Uservalidation.ps1 admin@prakdev.onmicrosoft.com Microsoft@123 admin@prakdev.onmicrosoft.com