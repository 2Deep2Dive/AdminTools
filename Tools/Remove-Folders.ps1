#Cleanup directores from xEmployees
$TransferFoldersList = Get-ChildItem -Path \\pdfs\transfer | Select-Object -ExpandProperty Name
$UserWorkFoldersList = Get-ChildItem -Path \\pdfs\UserWork | Select-Object -ExpandProperty Name
$DisabledADUsersList =  Get-ADUser -Filter * -SearchBase "OU=Disabled Users,DC=profidata,DC=com" | Select-Object -ExpandProperty SamAccountName

$TrasferFoldersToDelete = $DisabledADUsersList | Where-Object{$TransferFoldersList -contains $_}
$UserWorkFoldersToDelete = $DisabledADUsersList | Where-Object{$UserWorkFoldersList -contains $_}

Write-Host "Transfer Folder/s to be deleted!!" -ForegroundColor Red
Write-Host $TransferFoldersToDelete -ForegroundColor Yellow

Write-Host "UserWork Folder/s to be deleted!!" -ForegroundColor Red
Write-Host $UserWorkFoldersToDelete -ForegroundColor Yellow