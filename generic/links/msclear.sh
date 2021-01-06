#!/bin/bash




_clear(){
    _removefile 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual Studio Installer.lnk'
    _removefile 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Blend for Visual Studio 2015.lnk'
    _removefile 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Test Manager 2015.lnk'
}
_removefile(){
    local f="$1"
    [ -f "$f" ]||return 0
    (set -x;rm "$f")
}

_clear


