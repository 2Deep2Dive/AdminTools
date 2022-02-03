function Update-ChocolateyApp{
    param(
        [pscredential] $Cred,
        [String]$AppName,
        [String[]] $ComputerNames
    )
    foreach($ComputerName in $ComputerNames){
        try {
            Invoke-Command -ComputerName $ComputerName -Credential $Cred -ScriptBlock {
                #If Chocolaty is not installed then install it
                if((Test-Connection -Ping -TargetName $ComputerName -Count 1)){
                    HOSTNAME;
                    Write-host "Ugrading $AppName" -ForegroundColor red
                    choco upgrade $AppName -y --skip-if-not-installed
                }
                else {
                    HOSTNAME;
                    Write-host "$ComputerName is not reachable" -ForegroundColor Green
                }
            }
        }
        catch {
            Write-Host "$AppName Upgrade Faild!!"

        }

    }
}