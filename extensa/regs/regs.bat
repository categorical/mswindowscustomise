
@echo off

reg query "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v executionpolicy
:: Enables keying in some unicode characters,
:: e.g. hold ALT, press numpad plus (using Fn and / on laptop, OSK does not work), 2, 6, 3, a, release ALT, gives ☺.
::reg add "HKEY_CURRENT_USER\Control Panel\Input Method" /v EnableHexNumpad /t REG_SZ /d 1 /f 

:: Requires log off/on to see the effects.
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragHeight /d 120 /f
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragWidth /d 120 /f


::GOTO nopath
::reg delete "HKEY_CURRENT_USER\Environment" /v GOPATH /f
reg add "HKEY_CURRENT_USER\Environment" /v GOPATH /d "d:\godev" /f
set "mspath="
::set "mspath=%mspath%%%USERPROFILE%%\AppData\Local\Microsoft\WindowsApps;"
set "mspath=%mspath%d:\bin;"
set "mspath=%mspath%d:\sbin;"
set "mspath=%mspath%d:\opt\portablegit\bin;"
set "mspath=%mspath%d:\opt\jdk\bin;"
::reg add "HKEY_CURRENT_USER\Environment" /v Path /d "%mspath%" /f
setx "Path" "%mspath%"
reg query "HKEY_CURRENT_USER\Environment" /v Path

:nopath


:: Discards nonsense items from the side panel, requires restart explorer
set "msexplorer=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer"
reg add "%msexplorer%\advanced" /v showtaskviewbutton /d 0 /t reg_dword /f
::reg delete "%msexplorer%\advanced\people" /v peopleband /f
reg add "%msexplorer%\advanced\people" /v peopleband /d 0 /t reg_dword /f
::reg delete "%msexplorer%\advanced" /v taskbarsmallicons /f
reg add "%msexplorer%\advanced" /v taskbarsmallicons /d 1 /t reg_dword /f
::reg delete "%msexplorer%\advanced" /v taskbarglomlevel /f
reg add "%msexplorer%\advanced" /v taskbarglomlevel /d 2 /t reg_dword /f
::reg query "%msexplorer%\advanced"
reg add "%msexplorer%" /v enableautotray /d 0 /t reg_dword /f
::reg query "%msexplorer%"
reg add "%msexplorer%\hidedesktopicons\newstartpanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t reg_dword /d 1 /f

set "mssearch=HKCU\Software\Microsoft\Windows\CurrentVersion\Search"
reg add "%mssearch%" /v searchboxtaskbarmode /d 0 /t reg_dword /f
::reg query "%mssearch%"

reg add "hkcu\control panel\bluetooth" /v "notification area icon" /d 0 /t reg_dword /f
reg add "hkcu\control panel\desktop" /v "enableperprocesssystemdpi" /d 0 /t reg_dword /f


reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced" /v "hidefileext" /d 0 /t reg_dword /f
reg add "hkcu\software\microsoft\windows\currentversion\explorer\advanced" /v "hidden" /d 1 /t reg_dword /f

:: Stops microsoft from reopening its things:
:: has to be clicking, settings
::  :sign in options
::  :use my sign in info to automatically finish setting up my device and reopen my apps after an update or restart
::  :0
::reg add "hkcu\software\microsoft\windows nt\currentversion\winlogon" /v "restartapps" /d 0 /t reg_dword /f
::reg delete "hkcu\software\microsoft\windows nt\currentversion\winlogon" /v "restartapps" /f

:: Stops microsoft beeping at a user.
::reg query "hkcu\appevents\schemes\apps\.default\windowsuac\.current"
:: (Default)    REG_SZ    C:\Windows\media\Windows User Account Control.wav
for /f "delims=" %%a in ('
reg query "hkcu\appevents\schemes\apps\.default\windowsuac\.current" /ve
')do set "out=%%a"
if not "%out%"=="    (Default)    REG_SZ    (value not set)" (
reg delete "hkcu\appevents\schemes\apps\.default\windowsuac\.current" /ve /f)

reg add "hkcu\control panel\international" /v stimeformat /d "HH:mm:ss" /t reg_sz /f
