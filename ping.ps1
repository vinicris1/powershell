$ids = Get-Content "./ping.csv"
$list = @()

foreach ($id in $ids){
    $rs = ping $id /n 1 | Select-Object -Index 1

    if ($rs -match "Disparando (.+?) \[([\d.]+)\] com") {
        $domain = $matches[1]
        $list += "Dominio do servidor: $domain"
    } else {
        $list += "$id Nao foi possivel obter o dominio"
    }
}

for ($i=0; $i -le $list.count; $i++){
    Write-Host $list[$i]
}

$list | Out-File -FilePath "PingResult.csv"