#!/bin/bash
set -eu
_onexit(){ printf 'exit: %d\n' $?>&2;};trap _onexit EXIT
_inf(){ printf '\e[36mI: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;}
_Err(){ printf '\e[31mE: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;exit 1;}
thisdir=$(cd "$(dirname "$0")" && pwd)

reg='hklm\software\microsoft\windows nt\currentversion\image file execution options'
dbg='d:\opt\x64dbg\release\x64\x64dbg.exe'
_set(){ local "n=$1"
    local reg="$reg\\$n"
    sudo reg add "$reg" /f /d "$dbg" /t reg_sz /v debugger
}
_get(){ local "n=$1"
    local reg="$reg\\$n"
    reg query "$reg" /v debugger
    #sudo gflags /i "$n"
}
_unset(){ local "n=$1"
    local reg="$reg\\$n"
    local r=0;reg query "$reg" /v debugger &>/dev/null||r=$?
    if [ $r -eq 0 ];then
    sudo reg delete "$reg" /f /v debugger
    fi
}
_main(){ _usage(){ cat<<-EOF
	SYNOPSIS:
	    $0 -set|-unset|-get FILENAME
	EXAMPLE
	    $0 -get overpass.exe
	EOF
    exit $1;}
    declare -a a;while [ $# -gt 0 ];do case $1 in
        *)a+=("$1")
    esac;shift;done;set -- "${a[@]}"
    [ $# -gt 0 ]||_usage 1;while [ $# -gt 0 ];do case $1 in
        -set|--set)shift;_set "$1";;
        -unset|--unset)shift;_unset "$1";;
        -get|--get)shift;_get "$1";;
        -h)_usage 0;;*)_usage 1
    esac;shift;done
};_main "$@"
