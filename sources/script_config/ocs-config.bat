:: \\se3\Progs\ro\ocs\ocsConfig.bat
:: Configuration de l'installeur OCS
@echo off

Set SE3=##NETBIOS_NAME##
Set IpSe3=##IPSE3##
Set AdminSE3=adminse3
Set PassAdminSE3=##ADMINSE3PASS##

If "%OS%" == "Windows_NT" Goto ConfigOCS
echo La configuration d'OCS-NG doit se faire a partir d'un PC WinXP !
echo.
Goto FIN

:ConfigOCS
:: S'assurer que CPAU.exe est bien present a cet endroit!
Set CPAU=\\%SE3%\netlogon\CPAU.exe
:: Repertoire dans lequel ocs est dezippe
Set OcsDir=\\%SE3%\Progs\ro\inventory\deploy
:: Repertoire template base
Set TemplateDir=\\%SE3%\admhomes\templates\base

Set OcsJob=cpauOcs.job
Set TMPOCS=c:\tmpOcs

If Exist "%CPAU%" Goto MakeJob
echo Impossible d'acceder a :
echo %CPAU%
Goto FIN

:MakeJob
"%CPAU%" -u %AdminSE3% -p %PassAdminSE3% -lwp -wait -outprocexit -ex "%TMPOCS%\OcsAgentSetup.exe /S /server:%IpSe3% /pnum:909 /np /debug" -enc -file "%OcsDir%\%OcsJob%" >NUL
If "%ErrorLevel%"=="0" Goto ConfigOcsOK
echo Erreur de creation du job "%OcsDir%\%OcsJob%"
Goto FIN

:ConfigOcsOK
:: Creation du fichier BAT d'installation d'OCS-NG sur les postes Client W98 ou WinXP
echo :: Installation du service OCS sur les postes clients>%OcsDir%\ocs.bat
echo @echo OFF>>%OcsDir%\ocs.bat
:: Test si OCS est deja installe>%OcsDir%\ocs.bat
echo If "%%ProgramFiles%%" == "" Set ProgramFiles=C:\Program Files>>%OcsDir%\ocs.bat
echo If Exist "%%ProgramFiles%%\OCS Inventory Agent\OCSInventory.exe" Goto FIN>>%OcsDir%\ocs.bat
echo If Not Exist %TMPOCS%\NUL mkdir %TMPOCS%>>%OcsDir%\ocs.bat
echo if "%%OS%%" == "Windows_NT" goto InstWnt>>%OcsDir%\ocs.bat
echo.>>%OcsDir%\ocs.bat

echo :InstW9x>>%OcsDir%\ocs.bat
:: Pour les Win98, execution de OcsAgentSetup.exe directement a partir du serveur
echo echo Installation OCS-NG pour Win9x>>%OcsDir%\ocs.bat
echo "%OcsDir%\OcsAgentSetup.exe" /S /server:%IpSe3% /pnum:909 /np /debug>>%OcsDir%\ocs.bat
echo Goto InstOk>>%OcsDir%\ocs.bat

echo :InstWnt>>%OcsDir%\ocs.bat
echo echo Installation OCS-NG pour WinXP>>%OcsDir%\ocs.bat
echo xcopy /I /H /R /Y /Z /Q "%OcsDir%\*" %TMPOCS% ^>NUL>>%OcsDir%\ocs.bat
echo If Not Exist "%TMPOCS%\%OcsJob%" Goto Err2>>%OcsDir%\ocs.bat
echo "%CPAU%" -dec -file "%TMPOCS%\%OcsJob%" -nowarn -lwp -wait -outprocexit 2^>NUL ^>NUL>>%OcsDir%\ocs.bat
echo If ErrorLevel 1 Goto Err3>>%OcsDir%\ocs.bat
echo rmdir /S /Q "%TMPOCS%">>%OcsDir%\ocs.bat
echo Goto InstOk>>%OcsDir%\ocs.bat
echo.>>%OcsDir%\ocs.bat

echo :Err2>>%OcsDir%\ocs.bat
echo Echo Le fichier "%TMPOCS%\%OcsJob%" n'existe pas !>>%OcsDir%\ocs.bat

echo :Err3>>%OcsDir%\ocs.bat
echo rmdir /S /Q "%TMPOCS%">>%OcsDir%\ocs.bat
echo echo Erreur lors de l'installation d'OCS>>%OcsDir%\ocs.bat
echo goto FIN>>%OcsDir%\ocs.bat
echo.>>%OcsDir%\ocs.bat

echo :InstOk>>%OcsDir%\ocs.bat
echo Echo Installation OCS : OK.>>%OcsDir%\ocs.bat
echo.>>%OcsDir%\ocs.bat

echo :FIN>>%OcsDir%\ocs.bat

echo Felicitation! La configuration d'OCS est terminee.
echo.
find "%OcsDir%\ocs.bat" %TemplateDir%\logon.bat >NUL
if "%ERRORLEVEL%" == "0" Goto FIN1
echo. >> %TemplateDir%\logon.bat
echo call %OcsDir%\ocs.bat >> %TemplateDir%\logon.bat
echo La commande call %OcsDir%\ocs.bat 
echo a ete ajoutee au script de login de base.
echo.
:FIN1
echo OCS est desormais actif et s'installera sur les postes au prochain login.
echo.
:FIN
pause