:: Installation du service OCS sur les postes clients
@echo OFF
If "%ProgramFiles%" == "" Set ProgramFiles=C:\Program Files
If Exist "%ProgramFiles(x86)%" Set ProgramFiles=%ProgramFiles(x86)%
If Exist "%ProgramFiles%\OCS Inventory Agent\OCSInventory.exe" goto Uninst
If Exist "%ProgramFiles%\OCS Inventory Agent 2_1_1_1\uninst.exe" goto Fin

:Inst
:: Installation du nouveau client en version 2.1.1.1
"\\##NETBIOSNAME##\Progs\ro\inventory\deploy\OCS-NG-Windows-Agent-Setup.exe" /S /NOW /SERVER=http://##SE3IP##/ocsinventory /TAG=SE3 /SSL=0 /D=%ProgramFiles%\OCS Inventory Agent 2_1_1_1\
goto Fin

:Uninst
:: Deinstallation de l ancienne version d ocs
"%ProgramFiles%\OCS Inventory Agent\uninst.exe" /S
goto Inst

:Fin
