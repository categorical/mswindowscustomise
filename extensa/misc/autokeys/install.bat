

@echo off

set thisdir=%~dp0
::set "f=%thisdir%autokeys.cmd"
:: This one circumvents the dodgy cmd flashing window.
set "f=%thisdir%autokeys.vbs"
set "name=run:autokeys"

set "k=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
# Works (partially) and requires sudo.
::set "k=HKLM\Software\Microsoft\Windows\CurrentVersion\Run"

reg add "%k%" /v "%name%" /d "%f%" /f
reg query "%k%" /v "%name%"
::reg delete "%k%" /v "%name%" /f



pause

