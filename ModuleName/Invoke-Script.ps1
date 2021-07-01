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

#$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Win10,OU=WinDesktops,OU=Desktops,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
#$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Urdorf,OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
#$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Romania,OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
#$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Frankfurt,OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
#$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Luxemburg,OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName

$ADComputers = Get-ADComputer -Filter * -Properties *
$ADServers = $ADComputers | Where-Object OperatingSystem -Like "*Server*"
Write-Debug $ADServers | Format-Table Name, OperatingSystem

$TCPTestResults = foreach ($ADServer in $ADServers){
    Test-NetConnection -ComputerName $ADServer.DNSHostName -CommonTCPPort WINRM
}

$OnlineServers = $TCPTestResults | Where-Object TCPTestSucceeded -EQ $true


$ScriptBlock = {
    $Value = Test-Path "$($env:ProgramData)\chocolatey\choco.exe"
        if ($Value){
        $Version = choco; if($Version[0] -like "*business*"){$C4B = $true}
        if(!($C4B)){
            Write-Verbose "Installing C4B on $ComputerName"
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('http://chocorepo.profidatagroup.com/repository/choco-install/PDChocoVMInstall.ps1'))
        }
        else {

            #choco choco source add --name="'choco-hosted'" --source="'http://chocorepo.profidatagroup.com/repository/choco-hosted/'" --priority="'1'" --allow-self-service --bypass-proxy;
            choco upgrade chocolatey-license -yes --no-progress --limit-output ;
            #choco source remove --name="'choco-hosted'";
        }
    }
}
$Cred = (New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList  'profidata\dscadmin', (ConvertTo-SecureString -String 'Profi4Ever$2020' -AsPlainText -Force))
Invoke-Script -ComputerNames $OnlineServers  -Cred $Cred -ScriptBlock $ScriptBlock