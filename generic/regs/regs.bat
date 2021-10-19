



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
reg add "HKEY_CURRENT_USER\Environment" /v JAVA_HOME /d "d:\programs\jdk" /f
set "mspath="
set "mspath=%mspath%%%USERPROFILE%%\AppData\Local\Microsoft\WindowsApps;"
set "mspath=%mspath%d:\bin;"
set "mspath=%mspath%d:\sbin;"
set "mspath=%mspath%d:\godev\bin;"
set "mspath=%mspath%d:\programs\jdk\bin;"
set "mspath=%mspath%d:\programs\portablegit\bin;"
::reg add "HKEY_CURRENT_USER\Environment" /v Path /d "%mspath%" /f
setx "Path" "%mspath%"
reg query "HKEY_CURRENT_USER\Environment" /v Path

:nopath









