function Update-ChocolateyApp{
    param(
        [pscredential] $Cred,
        [String]$AppName
    )
    #Get All AD Computer Objects
    #$ADComputers = Get-ADComputer -Filter * -Properties *
    $ADComputers = Get-ADComputer -Filter * -Properties * -SearchBase 'OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com' | Select-Object DNSHostName,OperatingSystem
    #Filter AD Computer objetcs for servers
    $FilteredComputers = $ADComputers | Where-Object OperatingSystem -Like "*Windows 10 Pro*"
    Write-Information $FilteredComputers | Format-Table Name, OperatingSystem
    $DSNHostNames = $FilteredComputers | Select-Object -ExpandProperty DNSHostName
    #Test if servers are reachable and WINRM is responding
    $TCPTestResults = foreach ($DSNHostName in $DSNHostNames){
        Write-Output "Connecting to $DSNHostName"
        Test-NetConnection -ComputerName $DSNHostName -CommonTCPPort WINRM -ErrorAction SilentlyContinue -InformationLevel Quiet
    }
    $OnlineComputers = $TCPTestResults | Where-Object TCPTestSucceeded -EQ $true
    foreach($Computer in $OnlineComputers){
        try {
            Write-Debug "Starting remote job on $Computer"
            Invoke-Command -ComputerName $ComputerName -Credential $Cred -ScriptBlock {
                #If Chocolaty is not installed then install it
                HOSTNAME;
                Write-Information "Checking Chocolatey"
                $ChocoVersion = choco
                if($ChocoVersion[0] -like "*Business*"){
                    Write-host "Ugrading $AppName" -ForegroundColor red
                    choco upgrade $AppName -y --no-progress
                }
            } -AsJob
        }
        catch {
            Write-Host "$Computer Upgrade Faild!!"
        }
    }
}

$AppName = "'chocolatey-license' 'chocolatey' 'chocolatey-agent' 'chocolatey.extension' 'chocolateygui' 'chocolateygui.extension'"
$Cred = (New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList  'profidata\it-support', (ConvertTo-SecureString -String 'Profidata$2020' -AsPlainText -Force))

Update-ChocolateyApp -Cred $Cred -AppName $AppName
