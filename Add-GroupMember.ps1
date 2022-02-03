function Add-GroupMember {
    param (
        [String[]]$Member = "",
        [String]$GroupNameDE,
        [String[]]$ComputerNames,
        [String]$GroupNameEN,
        [pscredential] $Cred = ""
    )
    foreach($ComputerName in $ComputerNames){
        if((Test-Connection -ComputerName $ComputerName  -Count 1 -ErrorAction SilentlyContinue)){
            Write-Host "Invoking remote command on $ComputerName"
                try {
                    Invoke-Command -ComputerName $ComputerName -Credential $Cred  -ScriptBlock {
                        param($MemberName,$GroupNameEN,$GroupNameDE)
                        if(Get-LocalGroup -Name $GroupNameEN -ErrorAction SilentlyContinue){
                            Add-LocalGroupMember -Group $GroupNameEN -Member $MemberName -ErrorAction  SilentlyContinue
                        }
                        else {
                            Add-LocalGroupMember -Group $GroupNameDE -Member $MemberName -ErrorAction SilentlyContinue
                        }

                    } -ArgumentList $MemberName,$GroupNameDE,$GroupNameEN

                }
                catch {
                    Write-Host "Error User was not added"

                }
        }
    }
}