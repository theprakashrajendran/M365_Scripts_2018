Import-Module "C:\Prakash\Powershell\AzureAD\2.0.0.155\AzureAD"
Connect-AzureAD

Get-AzureADUser -ObjectID [EmailID of Flow Who Created] | Select-Object ObjectId
 

Get-AdminFlow -CreatedBy [Returned User Id]

Set-AdminFlowOwnerRole -PrincipalType User -PrincipalObjectId [NewUser who need Permission] -RoleName CanEdit -FlowName [FlowID] -EnvironmentName [EnvironmentGuid]