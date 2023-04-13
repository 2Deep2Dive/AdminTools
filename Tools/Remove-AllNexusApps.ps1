$Source =  "http://chocorepo.profidatagroup.com/repository/choco-test/"
$APIKey = "c3b834a7-9f77-34da-b889-ee79c708c6e5"
cd C:\Users\elm\Downloads
Write-Output "Retriving App's list"
$AppList = nuget.exe list -allversions -Source $Source
foreach($App in $AppList){
    $AppNameAndVersion = $App.split(" ")
    Write-Host "Deleting $($AppNameAndVersion[0]) $($AppNameAndVersion[1])" -ForegroundColor red
    nuget.exe delete  $AppNameAndVersion[0] $AppNameAndVersion[1]  -Source $Source -NonInteractive -apikey $APIKey
}