function Install-Chocolaty{
    param(
        [pscredential] $Cred,
        [String[]] $ComputerNames
    )
    foreach($ComputerName in $ComputerNames){
        try {
            Invoke-Command -ComputerName $ComputerName -Credential $Cred -ScriptBlock {
                #If Chocolaty is not installed then install it
                <# if(!(Test-Path -Path "$env:ProgramData\Chocolatey")){
                    HOSTNAME;
                    Write-host "Choco not Installed" -ForegroundColor red
                 #>    #[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('http://chocorepo.profidatagroup.com/repository/choco-install/PDChocoInstall.ps1'))


                #}
                <# else {
                    HOSTNAME;
                    Write-host "Choco Installed" -ForegroundColor Green
                } #>
            }
        }
        catch {
            Write-Host "Chocolaty Installation Faild!!"

        }

    }
}