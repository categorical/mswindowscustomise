
@echo off
call :iselevated

set "v1=hklm\system\currentcontrolset\services\lanmanworkstation\parameters"
set "v2=allowinsecureguestauth"
reg query "%v1%" /v "%v2%"
reg add "%v1%" /f /t reg_dword /d 1 /v "%v2%"
set "v1=hklm\software\policies\microsoft\windows\lanmanworkstation"
reg query "%v1%" /v "%v2%"
set "v1=hklm\software\policies\microsoft\windows defender"
set "v2=disableantispyware"
set "v1=hklm\software\policies\microsoft\windows defender\real-time protection"
set "v2=disablerealtimemonitoring"
reg query "%v1%" /v "%v2%"
reg add "%v1%" /f /t reg_dword /d 1 /v "%v2%"
powercfg /h off
sc config installservice start=disabled
sc config wuauserv start=disabled
set "v1=hklm\software\policies\microsoft\windowsstore"
reg add "%v1%" /f /t reg_dword /d 2 /v autodownload
set "v1=hklm\software\microsoft\windows\currentversion\policies\explorer"
reg add "%v1%" /f /t reg_dword /d 255 /v nodrivetypeautorun
set "v1=hklm\software\policies\microsoft\windows\windowsupdate\au"
reg add "%v1%" /f /t reg_dword /d 1 /v noautoupdate

set "v1=hklm\system\currentcontrolset\control\keyboard layout"
set "v2=0000000000000000030000005be01d001d005be000000000"
reg add "%v1%" /f /t reg_binary /d "%v2%" /v "scancode map"
reg query "%v1%" /v "scancode map"

echo [93mThe end of the script has been reached.[0m
pause
goto :eof

:iselevated
net session >nul 2>&1
if errorlevel 1 (
    set "_message=runas"
    call :err
)
goto :eof
:err
echo [101m---ERROR:[0m[91m %_message%[0m
set "_message="
pause
exit 1
goto :eof
:ok
echo [42m------OK:[0m[32m %_message%[0m
set "_message="
goto :eof
