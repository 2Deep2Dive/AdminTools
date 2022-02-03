function Get-DNSHostName {
    param(
        [pscredential] $Cred,
        [Parameter(Mandatory=$True)]
	    [ValidateSet('Urdorf','Romania','Frankfurt', 'Luxemburg', 'CS')]
        [String] $OUName,
        [ValidateSet('Urdorf','Romania','Frankfurt', 'Luxemburg', 'CS')]
        [String] $OS
    )

#TODO: Add missing oaramters
#TODO: Add switch to execute the AD query depending on the paramters provided
<#
- The function returns FQDN of AD computers
 - The function accespts OU name = location
 - The function accespts OS name
 #>

    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Win10,OU=WinDesktops,OU=Desktops,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Urdorf,OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Romania,OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Frankfurt,OU=Virtual Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=PDLUXVM,OU=Win10VM,OU=Win10,OU=WinDesktops,OU=Desktops,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Win2012,OU=WinSrv,OU=Servers,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Physical Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Win10,OU=Windows,OU=Notebooks,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
    #$ComputerNames = Get-ADComputer -Filter * -SearchBase "OU=Physical Workstations,OU=Win10,OU=Windows,OU=Workstations,OU=Profidata_Computers,OU=Profidata,DC=profidata,DC=com" | Select-Object -ExpandProperty DNSHostName
}