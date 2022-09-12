function Sync-xClinets {
    param (
        [Parameter(Mandatory=$True)]
        [string]$Source,
        [Parameter(Mandatory=$True)]
        [string]$Destination,
        [Parameter(Mandatory=$True)]
        [string]$LogPath,
        [Parameter(Mandatory=$True)]
        [int]$Daysback,
        [string[]]$Exclude
    )
    $CurrentDate = Get-Date
    $ItemsToCopy =  Get-ChildItem -Path $Source
    foreach($item in $ItemsToCopy){
        Invoke-RoboCopy -Source $($item.FullName) -Destination "$Destination\$($item.Name)" -ExcludeDirectory $Exclude -Force -Retry 2 -Wait 3 -Mirror -Threads 2 -LogFile "$Logpath$($item.Name)_SyncLog_$(Get-Date -Format "dd_MM_yyyy").log"
    }
    #Remove log files older than 6 days
    $DatetoDelete = $CurrentDate.AddDays($Daysback)
    Get-ChildItem $LogPath | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item
}
$Param = {
    Source      = "\\pdfsrv01\Xentis\Xentis_Clients"
    Destination = "D:\DFSRoots\xClients"
    LogPath     = "D:\xClient_Log\"
    Daysback    = -6
    Exclude     = "instances","etc"
}
Sync-xClinets @Param