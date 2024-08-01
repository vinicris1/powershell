###########################################################
#   Script para exportação e importação de certificados   #
#             Carlos Vinicius Cristofolini                #
###########################################################

# Set-ExecutionPolicy Unrestricted  -Scope CurrentUser

$name = "CN=XXX Root CA, DC=XXX, DC=com"
$certs = Get-ChildItem -Path Cert:\CurrentUser\My\*
$pass = ConvertTo-SecureString -String "@#y=fiA3(80>" -Force -AsPlainText
$path = "$ENV:SystemDrive\Temp\$env:USERNAME.pfx"

# Testa se existe o $ENV:SystemDrive\Temp se não existir cria 
$folderPath = "$ENV:SystemDrive\Temp"
if (!(Test-Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $folderPath
}

# Testa se o certificado já foi exportado por este script, se foi, ele importa o mesmo

if (Test-Path $path){
    
    Set-Location -Path Cert:\CurrentUser\My
    Import-PfxCertificate -FilePath $path -Password $pass -Exportable
    read-host "Import executado"

    #Cria um log com usuario, id do computador e data que executou a migração
    Set-Location -Path $ENV:SystemDrive

    $csvPath = "\\XXX.com\globalfs\Public\Migration.csv"
    if (!(Test-Path $csvPath)) { # Se não existir o csv cria
        New-Item -ItemType File -Force -Path $csvPath
        
        $acl = Get-Acl "\\XXX.com\globalfs\public\Migration.csv"
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users","Write","Allow")
        $acl.SetAccessRule($rule)
        Set-Acl "\\XXX.com\globalfs\public\Migration.csv" $acl
    }
    $date = get-date -Format "dd/MM"
    $array = @("$($env:USERNAME)","$($env:COMPUTERNAME)","$($date)")
    $array -join "`t" | Out-File -FilePath "\\XXX.com\GlobalFS\Public\Migration.csv" -Append
}else{
    if($certs.count -eq 1){
        try{
            # Exporta o certificado emitido pela XXX e coloca o password descrito em $pass
            Export-PfxCertificate -Cert $certs -FilePath $path -Password $pass 
            read-host "Export executado"            
        }catch{
            # Caso por algum motivo o script não consiga exportar o certificado ele gera um arquivo de log informando o erro
            "Não foi possivel exportar o certificado: $($_)" > "$ENV:SystemDrive\Temp\CertERROR.log"
        }
    }elseif($certs.count -gt 1){
        for($i = 0; $i -le $certs.count; $i++){
            if ($certs.Issuer[$i] -eq $name) { # Se existir mais de 1 certificado, exporta todos
                try{
    
                    # Exporta o certificado emitido pela XXX e coloca o password descrito em $pass
                    Export-PfxCertificate -Cert $certs[$i] -FilePath $($path + $i) -Password $pass 
                    read-host "Export executado"
                    
                }catch{
    
                    # Caso por algum motivo o script não consiga exportar o certificado ele gera um arquivo de log informando o erro
                    "Não foi possivel exportar o certificado: $($_)" > "$ENV:SystemDrive\Temp\CertERROR.log"
    
                }
            }
        }    
    }
}
exit
