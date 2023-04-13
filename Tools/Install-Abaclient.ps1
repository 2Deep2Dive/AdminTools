function Install-AbaClient{
    param(
        [pscredential] $Cred,
        [String[]] $ComputerNames
    )
    foreach($ComputerName in $ComputerNames){
        try {
            Invoke-Command -ComputerName $ComputerName -Credential $Cred -Authentication Credssp -ScriptBlock {choco upgrade abaclient -y;`
                Copy-Item "\\pdnas\INSTALL\Install\Abacus\AbaClient 2022\AbaClient.abalink" "C:\Program Files (x86)\Abacus\AbaClient\bin\";`
                $shell = New-Object -ComObject WScript.Shell;`
                $shortcut = $shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\AbaClient.lnk");`
                   $shortcut.TargetPath = "C:\Program Files (x86)\Abacus\AbaClient\bin\AbaClient.abalink";`
                   $shortcut.Save()}
        }
        catch {
            throw $_
            Write-Host "Abacus Installation Faild!!"

        }

    }
}
$Cred = Get-Credential
$ComputerNames  = ""
Install-AbaClient -Cred $Cred -ComputerNames $ComputerNames