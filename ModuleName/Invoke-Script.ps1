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
        try {
            Invoke-Command -computerName $ComputerName  -Credential $Cred -ScriptBlock $ScriptBlock
        }
        catch {
            throw $_
            Write-Output "Faild to Invoke Script!!"
        }
    }
}
#Get All AD Computer Objects
$ADComputers = Get-ADComputer -Filter * -Properties *
#Filter AD Computer objetcs for servers
$ADServers = $ADComputers | Where-Object OperatingSystem -Like "*Server*"
Write-Debug $ADServers | Format-Table Name, OperatingSystem
#Test if servers are reachable and WINRM is responding
$TCPTestResults = foreach ($ADServer in $ADServers){
    Test-NetConnection -ComputerName $ADServer.DNSHostName -CommonTCPPort WINRM
}
#Select reachabel and responding servers
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