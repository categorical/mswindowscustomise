
@echo off

powershell set-executionpolicy remotesigned >> "d:\scratch\outbar.log"
powershell -f "d:\dev\mswindowscustomise\extensa\regs\foo.ps1"




