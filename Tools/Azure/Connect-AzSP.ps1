#Check if the Azure PowerShell module is installed
#If yes update if not Install
if(get-module -Name 'Az' -ArgumentList){
    Update-module -Name 'Az' -Force
}
else {
    Install-Module -Name 'Az' -Verbose
 }

#Testing Azure authentication using Service Prenicipal
$tenantId = "2f44c52b-043a-4016-9dcb-83113fa640b3"
$SPID = "f0d0422f-73a7-4268-a601-4b771eba3b17"
$SPSecret = "I.58Q~dxzxxb_ZW.g~T4W90GRZ13hhsUihnNIbj."


$SecureStringPwd = $SPSecret | ConvertTo-SecureString -AsPlainText -Force
$pscredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SPID, $SecureStringPwd
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $tenantId -Verbose
#Here you add the commands you want to execute on the portal
#This is jsut an example, it retrives information about the resource groups named "PDDEVTools"
Get-AzResource -ResourceGroupName "PDDEVTools"

Get-AzContext | Disconnect-AzAccount