function Get-WindowsLicenseInfo{
    param(
        [pscredential] $Cred,
        [String[]] $ComputerNames
    )
    foreach($ComputerName in $ComputerNames){
        try {
            Invoke-Command -ComputerName $ComputerName -Credential $Cred -ScriptBlock {
                HOSTNAME;
                cscript C:\Windows\System32\slmgr.vbs -dli
            }
        }
        catch {
            Write-Host "Faild to retrive license information!!"

        }

    }
}