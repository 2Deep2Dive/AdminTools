$Cred = Get-Credential -Credential "profidata\Administrator"
$ComputerNames = "PDSCVMM02.profidata.com"
foreach($ComputerName in $ComputerNames ){
    if((Test-Connection -ComputerName $ComputerName  -Count 1 -ErrorAction SilentlyContinue)){
	    Write-Warning "Invoking remote command on $ComputerName"
        try{
	        Invoke-Command -ComputerName $ComputerName -Credential $Cred  -Authentication Credssp -ScriptBlock {
		        $Users = Get-ChildItem "C:\Users\" | Select-Object -ExpandProperty Name
		        ForEach ($User in $Users)
		        {
			        $UserPSRepoXMLPath = "c:\Users\$User\AppData\Local\Microsoft\Windows\PowerShell\PowerShellGet\"
			        IF ((Test-Path $UserPSRepoXMLPath -ErrorAction stop))
			        {
                        Copy-Item -Path "\\profidata.com\SYSVOL\profidata.com\scripts\PSRepositories.xml" -Destination "c:\Users\$User\AppData\Local\Microsoft\Windows\PowerShell\PowerShellGet\" -Force -Verbose -ErrorAction Stop
                        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
			        }
		        }
		    }
        }
        catch{
            throw $_
            Write-Error "Faild to Invoke Command on $ComputerName!!"
        }
    }
    else{
        Write-Error "Failed to reach $ComputerName"
    }
}