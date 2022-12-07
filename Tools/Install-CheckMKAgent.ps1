

#$VMNames = Get-Content -Path "C:\Users\elm\Documents\checkMK_hosts_list.csv"
$VMNames =  ""
$Destination = "$($ENV:PUBLIC)\Downloads"
$Agent = "check-mk-agent-2.1.0p12.msi"
$Uri = "http://itnexus/repository/Resources/CheckMK/$Agent"
$Cred = Get-Credential -Credential profidata\administrator

foreach ($VMName in $VMNames) {
    if(Test-NetConnection -ComputerName $VMName -CommonTCPPort WINRM -ErrorAction SilentlyContinue -InformationLevel Quiet){
        Invoke-Command -ComputerName "$VMName.profidata.com" -Credential $Cred {
            param($Destination, $Agent,$Uri)
            try {
                Invoke-WebRequest -Uri "$Uri" -OutFile "$Destination\$Agent" -ErrorAction Stop
            }
            catch {
                Write-Error "Failed to download CheckMK agent installtion file"
                Write-Output $_.Exception.Message
                Exit 1
            }
            try {
                Write-Output "Installing Agent"
                Set-Location $Destination
                Start-Process msiexec -Wait -ArgumentList "/i $Agent /qn"
            }
            catch {
                Write-Error "Failed to install CheckMK agent "
                Write-Output $_.Exception.Message
                Exit 1
            }
            try {
                Write-Output "Registering agent with CheckMK Server"
                $HostName = HOSTNAME
                Start-Process "C:\Program Files (x86)\checkmk\service\cmk-agent-ctl.exe" -wait -ArgumentList "register --hostname $HostName --server monitoring.profidata.com --site main --user networkadmin --password 'AJMDHBTSGHKVBXBJKEQB' --yes"
            }
            catch {
                Write-Error "Failed to register agent with CheckMK server"
                Write-Output $_.Exception.Message
                Exit 1
            }
        } -ArgumentList $Destination, $Agent,$Uri
    }
}