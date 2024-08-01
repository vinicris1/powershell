$path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\"
$subkeys = Get-ChildItem -Path $path
$embraco = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{c1d069b5-9cac-4900-8c70-a6d1dea92ace}"
$subemb = Get-ChildItem -Path $embraco

foreach($subkey in $subkeys){
    $subkeyPath = $subkey.PSPath #Get only the path name of the subkey

    try {
        $nameServer = Get-ItemProperty -Path $subkeyPath -Name "NameServer" -ErrorAction SilentlyContinue #Try to get the NameServer key
        
        if ($nameServer.NameServer -eq "127.0.0.1") { #Verify if any NameServer is 127.0.0.1
            Set-ItemProperty -Path "$($nameServer.NameServer)" -Name "NameServer" -Value $null #If yes set null
        }
    } catch {
        Write-Output "Error accessing $subkeyPath"
    }
}

foreach($sub in $subemb){
    $subkeyPt = $sub.PSPath
    try{
        $nameSvr = Get-ItemProperty -Path $subkeyPt -Name "NameServer" -ErrorAction SilentlyContinue
        if ($nameSvr.NameServer -eq "127.0.0.1") {
            $registryPath = "$embraco/$($nameSvr.PSChildName)"

            Set-ItemProperty -Path $registryPath -Name "NameServer" -Value $null
        }
    }
    catch{
        Write-Output "Error accessing $subkey"
    }
}