function Initialize-HVClusterNode {
    param(
        [String[]]$ComputerNames,
        [pscredential]$Cred,
        [ScriptBlock]$ScriptBlock
    )
    foreach($ComputerName in $ComputerNames){
        if((Test-Connection -ComputerName $ComputerName  -Count 1 -ErrorAction SilentlyContinue)){
            try {

                Invoke-Command -computerName $ComputerName  -Credential $Cred -ScriptBlock $ScriptBlock
            }
            catch {
                throw $_
                Write-Host "Faild to Invoke Command!!"
            }
        }
    }
}

#$ScriptBlock = {
#    Set-WinUserLanguageList -LanguageList ch-de -Force;
#    Set-WinHomeLocation -GeoId 223;
#    (Get-NetAdapter | where{$_.Name -like "* 1"}) | Disable-NetAdapterBinding -ComponentID ms_tcpip6
#    (gwmi win32_networkadapterconfiguration | where {$_.Index -eq 0}).SetTcpIpNetBios(2);
#    ([wmiclass]'Win32_NetworkAdapterConfiguration').enablewins($false,$false);
#    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name Shell -Value 'PowerShell.exe -NoExit';
#    Add-LocalGroupMember -Group Administrators -Member profidata\elm
#
#}
#$ScriptBlock = {
#    $TargetPortalAddresses = @("10.10.10.3","10.10.10.4");
#    $LocaliSCSIAddress = "10.10.10.2";
#    Foreach ($TargetPortalAddress in $TargetPortalAddresses){
#        New-IscsiTargetPortal -TargetPortalAddress $TargetPortalAddress -TargetPortalPortNumber 3260 -InitiatorPortalAddress $LocaliSCSIAddress
#    };
#    New-MSDSMSupportedHW -VendorId MSFT2005 -ProductId iSCSIBusType_0x9;
#    Foreach ($TargetPortalAddress in $TargetPortalAddresses){
#        Get-IscsiTarget | Connect-IscsiTarget -IsMultipathEnabled $true -TargetPortalAddress $TargetPortalAddress -InitiatorPortalAddress $LocaliSCSIAddress -IsPersistent $true
#    };
#    Set-MSDSMGlobalDefaultLoadBalancePolicy -Policy FOO;
#}