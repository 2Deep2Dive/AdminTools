$UsersList = Import-Csv C:\Users\administrator\Documents\export_ad_users_info_updated.csv -Delimiter ';' -Encoding UTF8
ForEach($UserInfo in $UsersList){
    $ADUser = Get-ADUser -Filter "Name -eq '$($UserInfo.Name)'"
    $ADUserManager = Get-ADUser -Filter "Name -eq '$($UserInfo.Manager)'"
    $ADUser| Set-ADUser -Department $UserInfo.Department -Title $UserInfo.Title -Company $UserInfo.Company -City $UserInfo.City -Manager $ADUserManager -Verbose
}