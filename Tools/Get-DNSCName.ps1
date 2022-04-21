function Get-DNSCName{
    param(
        [pscredential] $Cred,
        [String]$ComputerName,
        [String]$ZoneName
    )
    $PDCNames = invoke-command -ComputerName $ComputerName -Credential $Cred -ScriptBlock{param($ZoneName) Get-DnsServerResourceRecord -ZoneName $ZoneName -RRType CName} -ArgumentList $ZoneName
    return $PDCNames
}

#$cred = Get-Credential -UserName "profidata\administrator"
$Cred = (New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList  'profidata\administrator', (ConvertTo-SecureString -String 'Move2Urdorf%2' -AsPlainText -Force))
$ZoneName = "profidatagroup.com"
$ComputerName = "pddc116.profidata.com"

Get-DNSCName -cred $cred -computername $ComputerName -zonename $ZoneName | Select-Object HostName, @{Name="RecordData";e={$_.RecordData.HostNameAlias}}