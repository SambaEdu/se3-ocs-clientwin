:: Installation du script d install dans le demarrage du pc
@echo OFF
ver | find /i "version 5" > nul
if %errorlevel%==0 goto winxp
ver | find /i "version 6" > nul
if %errorlevel%==0 goto win7
ver | find /i "version 10" > nul
if %errorlevel%==0 goto win7

goto fin

:win7
If Exist "%allusersprofile%\Microsoft\Windows\Start Menu\Programs\Startup\ocsdeploy.bat" goto fin
xcopy /I /H /R /Y /Z /Q "\\##NETBIOSNAME##\Progs\ro\inventory\deploy\ocsdeploy.bat" "%allusersprofile%\Microsoft\Windows\Start Menu\Programs\Startup" >NUL
goto fin

:winxp
If Exist "%allusersprofile%\Menu D‚marrer\Programmes\D‚marrage\ocsdeploy.bat" goto fin
xcopy /I /H /R /Y /Z /Q "\\##NETBIOSNAME##\Progs\ro\inventory\deploy\ocsdeploy.bat" "%allusersprofile%\Menu D‚marrer\Programmes\D‚marrage" >NUL
goto fin

:fin