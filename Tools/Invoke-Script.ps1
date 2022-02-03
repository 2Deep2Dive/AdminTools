function Invoke-Script{
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