function Install-OracleClient {
    [CmdletBinding(ConfirmImpact='Low')]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $ConfigFilePath,
        [String]
        $DownloadPath = $env:USERPROFILE
    )
    try {
        # Check and load config file
        if(Test-Path $ConfigFilePath -ErrorAction Stop){
            $config=Get-Content -Path $ConfigFilePath -Raw | ConvertFrom-Json
            $Url = ($config.OracleClient.Url)+($config.OracleClient.name)+($config.OracleClient.version)+($config.OracleClient.Format)
        }
    }
    catch {
        Write-Error "Config file not found!"
        throw $_.Exception.Message
        {1:<#Do this if a terminating exception happens#>}
    }
    try {
        #Download zip file
        $Destination =  (($DownloadPath)+('\')+(($config.OracleClient.name)+($config.OracleClient.version)+($config.OracleClient.Format)))
        if(((Invoke-WebRequest -uri $Url -UseBasicParsing -DisableKeepAlive).StatusCode) -eq "200"){
            Start-BitsTransfer -Source $Url -Destination $Destination -ErrorAction Stop -Verbose
        }
    }
    catch {
        Write-Error "Failed to download file"
        throw $_.Exception.Message
        {1:<#Do this if a terminating exception happens#>}
    }
    try {
        #Check of 7zip is installed, if not install is via choclatey
        if(!(Test-Path "C:\Program Files\7-Zip\7z.exe" -ErrorAction SilentlyContinue)){
            Choco install 7zip --yes --no-progress --limit-output
        }
        #Extract files with full path
        #7z x $DownloadPath
    }
    catch {
        Write-Error "Files to extract Archive"
        throw $_.exception.Message
        {1:<#Do this if a terminating exception happens#>}
    }
    try {
        #Install Oracle Client using respons file
        if(!(Test-path "C:\oracle")){
            New-Item -Path "C:\" -ItemType Directory -Name "oracle" -ErrorAction Stop
        }
        Write-Host "Install Oracle Client" -ForegroundColor Yellow
        Get-ChildItem  -Path  (($DownloadPath)+('\')+(($config.OracleClient.name)+($config.OracleClient.version))) | Set-Location
        $RspFilePath = (Get-ChildItem -Path ((".\response\")+($config.OracleClient.response_file))).FullName
        Write-Host $RspFilePath
        Test-Path "setup.exe" -ErrorAction Stop | Out-Null
        Start-Process -FilePath ".\setup.exe" -ArgumentList "-silent -noconsole -responseFile $($RspFilePath)"
    }
    catch {
        Write-Error $_.exception.Message
        {1:<#Do this if a terminating exception happens#>}
    }
}
Install-OracleClient -ConfigFilePath $path