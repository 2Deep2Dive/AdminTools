Get-ADUser -Filter * -Properties * | Where-Object {($_.Department -ne $null) -and ($_.enabled -eq $true) -and ($_.Manager -eq $null) -and ($_.Department -notlike "*Abraxas*") } | select GivenName, Surname, Name, Department, Title, City, Company, @{n="Manager";e={get-aduser $_.manager | select -ExpandProperty name}} | ft -AutoSize

Get-ADUser -Filter * -Properties * | Where-Object {($_.Department -ne $null) -and ($_.enabled -eq $true) -and ($_.Manager -ne $null) -and ($_.Department -notlike "*Abraxas*") } | select GivenName, Surname, Name, Department, Title, City, Company, @{n="Manager";e={get-aduser $_.manager | select -ExpandProperty name}} | Export-Csv C:\Users\elm\Desktop\ad_users_info.csv -NoClobber -Encoding utf32 -Delimiter ';'

