
@echo off
call :iselevated

set "v1=hklm\system\currentcontrolset\services\lanmanworkspace\parameters"
reg query "%v1%" /v allowinsecureguestauth
reg add "%v1%" /f /t reg_dword /d 1 /v allowinsecureguestauth
:: gpedit
set "v1=hklm\software\policies\microsoft\windows\lanmanworkstation"
reg query "%v1%" /v allowinsecureguestauth

set "v1=hklm\software\policies\microsoft\windows defender"
reg query "%v1%" /v disableantispyware
reg add "%v1%" /f /t reg_dword /d 1 /v disableantispyware


echo [93mThe end of the script has been reached.[0m
pause
goto :eof

:iselevated
net session >nul 2>&1
if errorlevel 1 (
    set "_message=This script needs to be run as administrator."
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
