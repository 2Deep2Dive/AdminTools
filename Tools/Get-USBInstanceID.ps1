Get-PnpDevice -Class "DiskDrive" | select * | Sort InstanceID | ft
Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } |  select * | Sort Class | ft -AutoSize

Get-PnpDevice -PresentOnly -Class "DiskDrive"| Sort DeviceID | Ft -Property Name, DeviceID, ClassGuid, CompatibleID, HardwareID
Get-PnpDevice -PresentOnly | Where-Object { $_.DeviceId -like "*USB*" } | sort ClassGUID | Ft -Property Name, DeviceID, InstanceID, ClassGuid, HardwareID