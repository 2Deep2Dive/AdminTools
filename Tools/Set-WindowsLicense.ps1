function Set-WidowsLicense{
    param(
        [pscredential] $Cred,
        [String[]] $ComputerNames,
        [string] $ipk
    )
    foreach($ComputerName in $ComputerNames){
        try {
            Invoke-Command -ComputerName $ComputerName -Credential $Cred -ScriptBlock {
                cscript C:\Windows\System32\slmgr.vbs -ipk $ipk;
                cscript C:\Windows\System32\slmgr.vbs -ato;
            }
        }
        catch {
            Write-Host "Faild to retrive license information!!"

        }

    }
}