param ([string]$sGroupName,[string]$sTempEmail, [string]$UserName,[string]$password)
#[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
#Import-Module "C:\Users\scs01054\AppData\Local\Apps\SharePointPnPPowerShellOnline\Modules\SharePointPnPPowerShellOnline\SharePointPnP.PowerShell.Online.Commands.dll"  -warningaction "SilentlyContinue"

Try
{

$sPassword = ConvertTo-SecureString $password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $sPassword)

$proxysettings = New-PSSessionOption -ProxyAccessType IEConfig
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication "Basic" -AllowRedirection -SessionOption $proxysettings
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential 
Import-PSSession $Session -AllowClobber


Remove-UnifiedGroupLinks –Identity $sGroupName –Links $sTempEmail –LinkType Members -Confirm:$false

}
catch {
    write-host "Error: $($_.Exception.Message)" 
}

