   $vf_Dir="$env:SystemDrive"+"\temp\SAP_EPM"
   $vf_Log_File="$vf_Dir"+"\InstSAPEPMplugin.log"

   if ((Test-Path -Path $vf_Dir) -eq $False) {
       New-Item -Path $vf_Dir -type directory | Out-Null
   } 
#-------------------------------------------------------------------#
# Instala .NET 3.5                                                  #
#-------------------------------------------------------------------#

   $dotNet_exist = Test-Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5"
   if ($dotNet_exist -eq $TRUE) {
      Write-Host ".NET 3.5 Instalado"
  } else {
      $dotNetResource = Get-WindowsOptionalFeature -Online -FeatureName NetFx3
      #if($dotNetResource){
         Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3"
      <#}else{
         $vf_package_path = (Get-Location).ToString()
         $vf_package_path_file = $vf_package_path + '\' + 'dotnetfx35.exe'
         $arg = "/q /norestart"

         [String]$vf_Text_Log = "Installing .NET 3.5"
         $vf_Process = (Start-Process -FilePath $vf_package_path_file $arg -wait -PassThru)
         $vf_RC=$vf_Process.ExitCode
         [String]$vf_Text_Log = "Installation of DotNet 4.6.2 was finished with Return Code=$vf_RC"
      }#>
      
  }

#-------------------------------------------------------------------#
# Instala o EPM                                                     #
#-------------------------------------------------------------------#

   [String]$vf_Text_Log = "Performing the function Install_Sapepm..."

   $vf_package_path = (Get-Location).tostring()
   $pf_SapEpmVer='X32'
   $vf_package_path_file = $vf_package_path + '\' + 'EPM_Add-in_' + $pf_SapEpmVer + '.exe' 
   $vf_Arguments = '/S /v"INSTALLDIR=\"C:\Program Files (x86)\SAP BusinessObjects\EPM Add-In\" SETUPPHASE=Install CT_PROFILE=BPCMS CT_LANGUAGES=\"English\" /l*v \"c:\temp\SAP_EPM\InstSAPEPMplugin.log\" EPMLAUNCHER_ENABLE_REGISTRATION_OPTION=True MSIINSTALLPERUSER=0 EPMLAUNCHER_REGISTRATION=True EPMLAUNCHER_INSTALL_SHORTCUT_EXCEL=True /qn"'
   # $vf_Arguments = '/S /v"INSTALLDIR=\"C:\Program Files\SAP BusinessObjects\EPM Add-In\" SETUPPHASE=Install CT_PROFILE=BPCMS CT_LANGUAGES=\"English\" /l*v \"c:\temp\SAP_EPM\InstSAPEPMplugin.log\" EPMLAUNCHER_ENABLE_REGISTRATION_OPTION=True MSIINSTALLPERUSER=0 EPMLAUNCHER_REGISTRATION=True EPMLAUNCHER_INSTALL_SHORTCUT_EXCEL=True /qn"'
      #
   $vf_Title = "Install/Upgrade SAP EPM plugin"
   [String]$vf_Text_Log = "Start Install $pf_SapEpmVer"
   write-host $vf_Text_Log
   $vf_Process = (Start-Process -filepath $vf_package_path_file -argumentlist $vf_Arguments -wait -PassThru)
   $vf_RC=$vf_Process.ExitCode
   if ($vf_RC -gt 0) {
       [String]$vf_Text_Log = "; ${env:computername} ; Install ; $vf_package_path_file ; $pf_Package_Name ; RC ; $vf_RC"
       write-host $vf_Text_Log
   }
   [String]$vf_Text_Log = "Installation of SAP EPM was finished with Return Code=$vf_RC"
   write-host $vf_Text_Log

#-------------------------------------------------------------------#
# Instala o patch do SAP EPM                                        #
#-------------------------------------------------------------------#

   [String]$vf_Text_Log = "Performing the function Install_Sapepm..."

   $vf_package_path = (Get-Location).tostring()
   $pf_SapEpmVer='X32_PATCH'
   $vf_package_path_file = $vf_package_path + '\' + 'EPM_Add-in_' + $pf_SapEpmVer + '.exe' 
   $vf_Arguments = '/S /v"INSTALLDIR=\"C:\Program Files (x86)\SAP BusinessObjects\EPM Add-In\" SETUPPHASE=Install CT_PROFILE=BPCMS CT_LANGUAGES=\"English\" /l*v \"c:\temp\SAP_EPM\InstSAPEPMpluginpatch.log\" EPMLAUNCHER_ENABLE_REGISTRATION_OPTION=True MSIINSTALLPERUSER=0 EPMLAUNCHER_REGISTRATION=True EPMLAUNCHER_INSTALL_SHORTCUT_EXCEL=True /qn"'
   # $vf_Arguments = '/S /v"INSTALLDIR=\"C:\Program Files\SAP BusinessObjects\EPM Add-In\" SETUPPHASE=Install CT_PROFILE=BPCMS CT_LANGUAGES=\"English\" /l*v \"c:\temp\SAP_EPM\InstSAPEPMplugin.log\" EPMLAUNCHER_ENABLE_REGISTRATION_OPTION=True MSIINSTALLPERUSER=0 EPMLAUNCHER_REGISTRATION=True EPMLAUNCHER_INSTALL_SHORTCUT_EXCEL=True /qn"'
      #
   $vf_Title = "Install/Upgrade SAP EPM plugin"
   [String]$vf_Text_Log = "Start Install $pf_SapEpmVer"
   write-host $vf_Text_Log
   $vf_Process = (Start-Process -filepath $vf_package_path_file -argumentlist $vf_Arguments -wait -PassThru)
   $vf_RC=$vf_Process.ExitCode
   if ($vf_RC -gt 0) {
       [String]$vf_Text_Log = "; ${env:computername} ; Install ; $vf_package_path_file ; $pf_Package_Name ; RC ; $vf_RC"
       write-host $vf_Text_Log
   }
   [String]$vf_Text_Log = "Installation of SAP EPM PATCH was finished with Return Code=$vf_RC"
   write-host $vf_Text_Log

