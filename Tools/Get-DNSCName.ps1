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
$Cred = $Cred = Get-Credential -Credential "profidata\Administrator"
$ZoneName = "profidatagroup.com"
$ComputerName = "pddc116.profidata.com"

Get-DNSCName -cred $cred -computername $ComputerName -zonename $ZoneName | Select-Object HostName, @{Name="RecordData";e={$_.RecordData.HostNameAlias}}