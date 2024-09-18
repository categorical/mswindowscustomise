#!/bin/bash
set -eu
trap 'printf "exit %d\n" $?>&2' EXIT
say(){ printf '\e[36mI: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;}
die(){ printf '\e[31mE: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;exit 1;}
thisdir=$(cd "$(dirname "$0")" && pwd)


u='hklm\software\microsoft\windows nt\currentversion\image file execution options\%s\perfoptions'
w='cpupriorityclass'

show(){
local "pe=$1"
local "u=$(printf "$u" "$pe")"
reg query "$u" /v "$w"
}
add(){
local "pe=$1"
local "u=$(printf "$u" "$pe")"
reg add "$u" /f /d "$n" /t reg_dword /v "$w"
}
del(){
local "pe=$1"
local "u=$(printf "$u" "$pe")"
reg delete "$u" /f /v "$w"
}

main(){ usage(){ cat<<EOF
$0 -del|-show PROG
$0 -add PROG [-low|-norm|-hi]
EOF
    exit $1;}
    local a n=2;while [ $# -gt 0 ];do case $1 in
        -low)n=1;;-norm)n=2;;-hi)n=3;;
        *)a+=("$1")
    esac;shift;done;set -- "${a[@]}"
    [ $# -gt 0 ]||usage 1;while [ $# -gt 0 ];do case $1 in
        -del)shift;del "$1";;
        -add)shift;add "$1";;
        -show)shift;show "$1";;
        -h)usage 0;;*)usage 1
    esac;shift;done
};main "$@"
