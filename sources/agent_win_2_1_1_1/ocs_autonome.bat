:: Installation du service OCS sur les postes clients hors SE3
:: copier ce batch et le fichier OCS-NG-Windows-Agent-Setup.exe sur une cle usb pour l executer sur d autres postes
@echo OFF
If "%ProgramFiles%" == "" Set ProgramFiles=C:\Program Files
If Exist "%ProgramFiles(x86)%" Set ProgramFiles=%ProgramFiles(x86)%
If Exist "%ProgramFiles%\OCS Inventory Agent\OCSInventory.exe" goto Uninst
If Exist "%ProgramFiles%\OCS Inventory Agent 2_1_1_1\OCSInventory.exe" goto Fin

:Inst
:: Installation du nouveau client en version 2.1.1.1
"OCS-NG-Windows-Agent-Setup.exe" /S /NOSPLASH /NOW /SERVER=http://##SE3IP##/ocsinventory /TAG=AUTRE /SSL=0 /D=%ProgramFiles%\OCS Inventory Agent 2_1_1_1\
goto Fin

:Uninst
:: Deinstallation de l ancienne version d ocs
"%ProgramFiles%\OCS Inventory Agent\uninst.exe" /S
goto Inst

:Fin
