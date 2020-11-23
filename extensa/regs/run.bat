

set "k=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
::set "k=HKLM\Software\Microsoft\Windows\CurrentVersion\Run"

set "progname=foo"
set "progpath=d:\dev\mswindowscustomise\extensa\regs\foo.cmd"

reg add %k% /v %progname% /d "%progpath%" /f
reg query "%k%" /v %progname%
::reg delete %k% /v %progname% /f

reg query "%k%" 



