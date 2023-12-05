$AppsList = nuget.exe list -Source $Sources "http://chocorepo.profidatagroup.com/repository/choco-prod"
 $NewAppList = @()
 $FilePath = "Chocolatey_Applications.csv"
 New-Item -ItemType file -Path  $FilePath
 "Name,Version" | Add-Content -Path $FilePath

 foreach ($App in $AppsList) {
            $NameAndVersion = ($App).Split(" ")
            "{0},{1}" -f $($NameAndVersion[0]),$($NameAndVersion[1]) | Add-Content -Path $FilePath
            #Write-Output "$($NameAndVersion[0]) $($NameAndVersion[1])"
 }