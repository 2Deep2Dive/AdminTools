
$Sources =  "http://chocorepo.profidatagroup.com/repository/choco-prod/"
$APIKey = "c3b834a7-9f77-34da-b889-ee79c708c6e5"


cd C:\Users\elm\Downloads
Write-Output "Retriving App's list"
$AppList = nuget.exe list -Source $Sources

foreach($AppFullName in $AppList){
    Write-Verbose "Retriving the app name without the version"
    $AppName = $AppFullName.split(" ")[0]
    $LatestAppVersion = nuget.exe list "$AppName"  -Source $Sources | Where-Object{$_.contains("$AppName")}
    $AllAppVersions = nuget.exe list "$AppName"  -allversions -Source $Sources | Where-Object{$_.contains("$AppName")}
    foreach ($AppVersion in $AllAppVersions) {
        if(!($LatestAppVersion.Contains("$AppVersion"))){
            $NameAndVersion = ($AppVersion).Split(" ")
            Write-Output "Deleting $($NameAndVersion[0]) $($NameAndVersion[1])"
            foreach($Source in $Sources){
                nuget.exe delete  $NameAndVersion[0] $NameAndVersion[1]  -Source $Source -NonInteractive -apikey $APIKey
            }
        }
    }
}

