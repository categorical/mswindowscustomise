#!/bin/bash
set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_warnf(){ local f=$1;shift;printf "\033[33mwarning: \033[0m%s\n" "$(printf "$f" "$@")";}
_list(){
    ls -lA "$(cygpath -D)" "$(cygpath -DA)"|grep -v ^total|grep -v ^$
}

_kill(){
    while IFS= read -r;do
        case "$(basename "$REPLY")" in
            desktop.ini);;
            *.lnk)(set -x;rm "$REPLY");;
            *);;
        esac
    done< <(find "$(cygpath -D)" "$(cygpath -DA)" -mindepth 1 -maxdepth 1)
}

_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 -l|--list
	    $0 -k|--kill
	EXAMPLES
	    $0 -l -k -l
	EOF
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -l|--list)_list;;
    -k|--kill)_kill;;
    *)_usage 0;;
esac;shift;done


