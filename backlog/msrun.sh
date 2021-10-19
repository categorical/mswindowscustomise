#!/bin/bash



reg query 'hklm\software\microsoft\windows\currentversion\run'
reg query 'hkcu\software\microsoft\windows\currentversion\run'
reg query 'hklm\software\microsoft\windows\currentversion\runonce'
reg query 'hkcu\software\microsoft\windows\currentversion\runonce'

reg query 'hklm\software\wow6432node\microsoft\windows\currentversion\run'
reg query 'hkcu\software\wow6432node\microsoft\windows\currentversion\run'

reg query 'hklm\software\microsoft\windows\currentversion\explorer\startupapproved\run'
reg query 'hkcu\software\microsoft\windows\currentversion\explorer\startupapproved\run'

ls "$ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
ls "$APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# ms uwp apps
#   disable->settings: startup 
#   clean->remove the app




