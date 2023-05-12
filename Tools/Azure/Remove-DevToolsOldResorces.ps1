if(Connect-AzAccount -Credential $(Get-Credential) -Subscription "ProCloud Azure Subscription 01"){
    Get-AzResource -ResourceGroupName PDDEVTools
    Get-AzResource -ResourceGroupName PDDEVTools -ResourceType Microsoft.Compute/virtualMachines   | Remove-AzResource -Verbose -Force -WhatIf
    Get-AzResource -ResourceGroupName PDDEVTools -ResourceType Microsoft.Network/networkInterfaces | Remove-AzResource -Verbose -Force -WhatIf
    Get-AzResource -ResourceGroupName PDDEVTools -ResourceType Microsoft.Network/bastionHosts      | Remove-AzResource -Verbose -Force -WhatIf
    $vNet = Get-AzResource -ResourceGroupName PDDEVTools -ResourceType Microsoft.Network/virtualNetworks -ExpandProperties
    $vNet.Properties.subnets | Remove-AzResource -Verbose -Force -WhatIf
    Get-AzResource -ResourceGroupName PDDEVTools -ResourceType Microsoft.Compute/sshPublicKeys | Remove-AzResource -Verbose -Force -WhatIf
    Get-AzResource -ResourceGroupName PDDEVTools -ResourceType Microsoft.Network/publicIPAddresses | Remove-AzResource -Verbose -Force -WhatIf
    Get-AzResource -ResourceGroupName PDDEVTools -ResourceType Microsoft.Network/networkSecurityGroups | Remove-AzResource -Verbose -Force -WhatIf
    $vnet | Remove-AzResource -Verbose -Force
}
