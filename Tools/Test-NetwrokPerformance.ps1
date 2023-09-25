$LogFileLocation = "C:\Test\"
$LogFileName = "Copy_log.log"
$ReportName = "report.csv"

$FileToCopy = "C:\Test\tmp_source\test.txt"
$DestinationToCopy = "c:\Test\tmp_destination\"


#$MinSeconds = (New-TimeSpan -Minutes 1).TotalSeconds
#$MaxSeconds = (New-TimeSpan -Minutes 8).TotalSeconds

$TimeStamp = get-date -format "dd.MM.yyyy hh:MM:ss"

#TODO: Create CSV File
try {
    if (!(Test-path "$LogFileLocation\$ReportName" -ErrorAction SilentlyContinue)) {
        New-Item -ItemType file -Path "$LogFileLocation\$ReportName"-ErrorAction Stop
        "Date,FileToCopy,Sleep" | Add-Content -Path "$LogFileLocation\$ReportName"
        Write-Output "$(get-date -format "dd.MM.yyyy hh:MM:ss") created $ReportName"
    }
}
catch {
    Write-Output "Failed to create new CSV File "
    Throw $_.Exception.Message
    Exit 1
}

#TODO:Copy File nad mesure
$CopyTime = (measure-command -Expression { Copy-Item -Path $FileToCopy -Destination $DestinationToCopy }).TotalSeconds

#TODO Sleep for some seconds
$SleepTime = (Get-Random -Minimum $((New-TimeSpan -Minutes 1).TotalSeconds) -Maximum $((New-TimeSpan -Minutes 8).TotalSeconds))

#TODO Add data to CSV

"{0},{1},{2}" -f $TimeStamp,$CopyTime,$SleepTime |Add-Content -path (Join-Path -Path $LogFileLocation -ChildPath $ReportName)
