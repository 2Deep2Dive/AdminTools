#Cleanup directores from xEmployees
$TransferFoldersList = ls -Path \\pdfs\transfer | select -ExpandProperty Name
$UserWorkFoldersList = ls -Path \\pdfs\UserWork | select -ExpandProperty Name
$DisabledADUsersList =  Get-ADUser -Filter * -SearchBase "OU=Disabled Users,DC=profidata,DC=com" | select -ExpandProperty SamAccountName

$TrasferFoldersToDelete = $DisabledADUsersList | ?{$TransferFoldersList -contains $_}
$UserWorkFoldersToDelete = $DisabledADUsersList | ?{$UserWorkFoldersList -contains $_}

Write-Host "Transfer Folder/s to be deleted!!" -ForegroundColor Red
Write-Host $TransferFoldersToDelete -ForegroundColor Yellow

Write-Host "UserWork Folder/s to be deleted!!" -ForegroundColor Red
Write-Host $UserWorkFoldersToDelete -ForegroundColor Yellow