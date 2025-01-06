param ([string]$userName, [string]$password,[string]$sAssignEmail, [string]$roleName)

Import-Module "C:\BatchJobs\Modules\AzureAD\2.0.0.155\AzureAD"
$sPassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($userName, $sPassword)

Try
{
    Connect-AzureAD -Credential $cred 
}
catch
{
    write-host "Error in Connect AzureAD :" $_.Exception.Message
}
    $roleName = $roleName  -replace "#@#@", " " 
    $role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}  
    if ($role -eq $null) {
        $roleTemplate = Get-AzureADDirectoryRoleTemplate | Where {$_.displayName -eq $roleName}  
        Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId
        $role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}   
    }

Try
{
    cls
    #Add/Grant Role to User
     $userObjectId = Get-AzureADUser -ObjectId  $sAssignEmail  | Select-Object ObjectId
    Add-AzureADDirectoryRoleMember -ObjectId   $role.ObjectID  -RefObjectId  $userObjectId.ObjectId
    #(Get-AzureADUser | Where {$_.UserPrincipalName -eq $sAssignEmail}).ObjectID
    Write-Host "Valid"  
}
catch
{
    write-host "ErrorMessage" $_.Exception.Message
}


