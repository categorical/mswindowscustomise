

@echo off

set thisdir=%~dp0
::set "f=%thisdir%autokeys.cmd"
:: This one circumvents the dodgy cmd flashing window.
set "f=%thisdir%autokeys.vbs"
set "name=run:autokeys"
:: Microsoft's optical salon installer thinks it should open a vbs file for you,
:: therefore wscript.exe has to be explicit.
set "executable=%systemroot%\system32\wscript.exe"


set "k=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
:: Works (partially) and requires sudo.
::set "k=HKLM\Software\Microsoft\Windows\CurrentVersion\Run"

reg add "%k%" /v "%name%" /d "\"%executable%\" ""%f%""" /f
reg query "%k%" /v "%name%"
::reg delete "%k%" /v "%name%" /f



pause

