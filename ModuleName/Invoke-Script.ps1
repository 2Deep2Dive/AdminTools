function Invoke-Script{
    param(
        [Parameter(ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String[]]$ComputerNames,
        [ValidateNotNullOrEmpty()]
        [pscredential]$Cred,
        [ValidateNotNullOrEmpty()]
        [ScriptBlock]$ScriptBlock
    )
    foreach($ComputerName in $ComputerNames){
        # Test if system is reachable
        if((Test-Connection -ComputerName $ComputerName  -Count 1 -ErrorAction SilentlyContinue)){
            try {
                                    
                Invoke-Command -computerName $ComputerName  -Credential $Cred -ScriptBlock $ScriptBlock
            }
            catch {
                throw $_
                Write-Output "Faild to Invoke Script!!"
            }
        }
    }
}

$ScriptBlock = {
    }