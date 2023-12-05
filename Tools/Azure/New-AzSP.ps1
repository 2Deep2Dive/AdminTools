#Testing creating new Azure Service Principal for authentication
Connect-AzAccount -Credential $(Get-Credential -Credential 'mohamed.eliwa@profidata.com') -Subscription "ProCloud Azure Subscription 01"
$sp = New-AzADServicePrincipal -DisplayName "ELM-Test-SPN"
Write-Host $sp -ForegroundColor Cyan
$sp.PasswordCredentials.SecretText | ConvertTo-SecureString -AsPlainText -Force
Disconnect-AzAccount -Username 'mohamed.eliwa@profidata.com'