###########################################################
#
#	Script Name: Activator
#	Version: 1.0
#	Author: KT
#	Date: 	09/02/2023 17:13:36
#
#	Description: Agent reinstall script
#
###########################################################


#region---------------Start Here--------------------#

$mypath = $MyInvocation.MyCommand.Path

#Check PowerShell Version and Exit if less than 3
if ($PSVersionTable.PSVersion.Major -le 3){[Console]::WriteLine("Error please upgrade Powershell");Exit 1}

#check PS version, download and install modules needed.
if ($PSVersionTable.PSVersion.Major -eq 5){
if (Get-Module -ListAvailable -Name AzureRM) {
    Write-Host "########## PowerShell Modules exists ##########"

} else {
    Write-Host "########## Installing PowerShell Modules ##########"
#    Install-PackageProvider Nuget –Force
    Install-Module –Name PSWindowsUpdate -AllowClobber –Force
    Import-Module PowerShellGet
    Write-Host "##### Completed Installing PowerShell Modules #####"
}
}


Function Set-KMSKey{
    Write-Host "################## Clearing Keys #################"
slmgr.vbs //B /upk
slmgr.vbs //B /cpky
slmgr.vbs //B /ckms
    Write-Host "################# Adding New Keys ################"
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T
slmgr //B /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr //B /skms kms8.msguides.com
    Write-Host "################### Activating ###################"
slmgr //B /ato
}

Set-KMSKey
    Write-Host "####################### Done #####################"
Start-Sleep 5
#$sls = Get-WmiObject -Query 'SELECT * FROM SoftwareLicensingService'
#$sls.RefreshLicenseStatus()

#Write-Output -InputObject 'This script will self-destruct in 5 seconds.'
# 
#5..1 | ForEach-Object {
#    If ($_ -gt 1) {
#        "$_ seconds"
#    } Else {
#        "$_ second"
#    } # End If.
#    Start-Sleep -Seconds 1
#} # End ForEach-Object.
 
# Here's the command to delete itself.
#Remove-Item -Path $MyInvocation.MyCommand.Source