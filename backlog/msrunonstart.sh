#!/bin/bash
set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_warnf(){ local f=$1;shift;printf "\033[33mwarning: \033[0m%s\n" "$(printf "$f" "$@")";}
_onexit(){ printf 'exit: %d\n' $?>&2;};trap _onexit EXIT
#dthis="$(dirname "$(readlink -f "$0")")"
#dthis="$(cd "$(dirname "$0")"&&pwd)"

_list(){
    _regquery 'hklm\software\microsoft\windows\currentversion\run'
    _regquery 'hkcu\software\microsoft\windows\currentversion\run'
    _regquery 'hklm\software\microsoft\windows\currentversion\runonce'
    _regquery 'hkcu\software\microsoft\windows\currentversion\runonce'
    
    _regquery 'hklm\software\wow6432node\microsoft\windows\currentversion\run'
    _regquery 'hkcu\software\wow6432node\microsoft\windows\currentversion\run'
    
    _regquery 'hklm\software\microsoft\windows\currentversion\explorer\startupapproved\run'
    _regquery 'hkcu\software\microsoft\windows\currentversion\explorer\startupapproved\run'
    
    _ls "$ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
    _ls "$APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
    
    # ms uwp apps
    #   disable->settings: startup 
    #   clean->remove the app
}
_regquery(){
    while read -r;do
        _warnf '%s' "$REPLY"
    done< <(reg query "$1" 2>/dev/null|sed 's/\x0d$//;/^$/d')
}
_ls(){
    #_infof '%s' "$(cygpath -u "$1")"
    while read -r;do case "$(basename "$REPLY")" in
        desktop.ini);;
        *)_warnf '%s' "$REPLY";;
    esac;done< <(find "$1" -mindepth 1)
}

_kill(){
    
    sudo "$0" --killelevated
}
_killelevated(){
    #HKEY_LOCAL_MACHINE\software\wow6432node\microsoft\windows\currentversion\run
    #BCSSync    REG_SZ    "C:\Program Files (x86)\Microsoft Office\Office14\BCSSync.exe" /DelayServices
    reg delete 'hklm\software\wow6432node\microsoft\windows\currentversion\run' /v bcssync /f   
}

_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -l|--list
	    $0 -k|--kill
	EXAMPLES
	    $0 -l -k -l
	EOF
    exit $1
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -l|--list)_list;;
    -k|--kill)_kill;;
    --killelevated)_killelevated;;
    *)_usage 0;;
esac;shift;done



