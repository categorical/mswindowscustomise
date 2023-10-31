#!/bin/bash
set -eu
_onexit(){ printf 'exit: %d\n' $?>&2;};trap _onexit EXIT
_inf(){ printf '\e[36mI: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;}
_Err(){ printf '\e[31mE: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;exit 1;}

thisdir=$(cd "$(dirname "$0")" && pwd)

_rw(){
    local s='b:'
    local bina="$(cygpath -S)/mount.exe"
    net use
    case ${isnop-} in t)return;esac
    local c="[ ! -e '$(cygpath -u "$s")' ]||net use '$s' /y /delete"
    case ${isu-} in t)
        bash -c "$c";sudo bash -c "$c"
        return
    esac
    c="$c;'$bina' '\\\\10.2.2.2\\sta\\c\\sambaro' '$s'"
    bash -c "$c";sudo bash -c "$c"
}
_rwuid(){
    local c='hklm\software\microsoft\clientfornfs\currentversion\default'
    local b=annonymousuid
    local r=0;reg query "$c" /v "$b" 2>/dev/null||r=$?
    case ${isnop-} in t)return;esac
    case ${isu-} in t)
        [ $r -eq 0 ]||return 0
        sudo reg delete "$c" /f /v "$b"
        return
    esac
    sudo reg add "$c" /f /d 1000 /t reg_dword /v "$b"
}
_nfsc(){
    local n='clientfornfs-infrastructure'
    local bina="$(cygpath -S)/dism.exe"
    #sudo powershell -c "get-windowsoptionalfeature -online -featurename '$n'"
    sudo "$bina" /online /get-featureinfo "/featurename:$n"
    case ${isnop-} in t)return;esac
    case ${isu-} in t)
    # need reboot
    sudo "$bina" /norestart /online /disable-feature "/featurename:$n"
    return
    esac
    sudo "$bina" /online /enable-feature "/featurename:$n"
}
_ro(){
    local s='s:'
    case ${isnop-} in t)return;esac

    local c="$(cat<<-EOF
	[ ! -e '$(cygpath -u "$s")' ]||net use '$s' /y /delete
	EOF
    )"
    case ${isu-} in t)
        bash -c "$c";sudo bash -c "$c"
        return
    esac
    c="$(cat<<-EOF
	$c
	net use '$s' '\\\\10.2.2.2\\b' '' /user:
	EOF
    )"
    bash -c "$c";sudo bash -c "$c"
}
_main(){ _usage(){ cat<<-EOF
	SYNOPSIS:
	    $0 --rw|--ro [-u]
	EOF
    exit $1;}
    declare -a a;while [ $# -gt 0 ];do case $1 in
        -u)isu=t;;
        --nop)isnop=t;;
        *)a+=("$1")
    esac;shift;done;set -- "${a[@]}"
    [ $# -gt 0 ]||_usage 1;while [ $# -gt 0 ];do case $1 in
        --rw)_rw;;
        --ro)_ro;;
        --rwuid)_rwuid;;
        --nfsc)_nfsc;;
        -h)_usage 0;;*)_usage 1
    esac;shift;done
};_main "$@"
