#!/bin/bash
set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_warnf(){ local f=$1;shift;printf "\033[33mwarning: \033[0m%s\n" "$(printf "$f" "$@")";}
_onexit(){ printf 'exit: %d\n' $?>&2;};trap _onexit EXIT
isdry=;_dry(){ if [ "$isdry" = 't' ];then _warnf '%s' "$*";else (set -x;"$@");fi;}

# rubbish files
declare -ar vs=(
    'd:\msdownld.tmp' #rtss
)
declare -a ws;mapfile -t ws< <(
    while read -r;do case "$(basename "$REPLY")" in
        desktop.ini);;
        *.lnk)printf '%s\n' "$REPLY";;
        *);;
    esac;done< <(find "$(cygpath -D)" "$(cygpath -DA)" -mindepth 1 -maxdepth 1)
)

_list(){
    #ls -lA "$(cygpath -D)" "$(cygpath -DA)"|grep -v ^total|grep -v ^$
    for v in "${vs[@]}" "${ws[@]}";do v="$(cygpath -u "$v")"
        test -e "$v"&&_warnf '%s' "$v"||:
    done
}

_kill(){
    for v in "${vs[@]}" "${ws[@]}";do v="$(cygpath -u "$v")"
        test -f "$v"&&_dry rm "$v"
        test -d "$v"&&_dry rm -r "$v"
    done||:
}



_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 -l|--list
	    $0 [--dry] -k|--kill
	EXAMPLES
	    $0 --dry -k
	    $0 -l -k -l
	EOF
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -l|--list)_list;;
    -k|--kill)_kill;;
    --dry)isdry='t';;
    *)_usage 0;;
esac;shift;done


