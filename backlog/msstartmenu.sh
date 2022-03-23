#!/bin/bash
set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_warnf(){ local f=$1;shift;printf "\033[33mwarning: \033[0m%s\n" "$(printf "$f" "$@")";}
_onexit(){ printf 'exit: %d\n' $?>&2;};trap _onexit EXIT
#dthis="$(dirname "$(readlink -f "$0")")"
#dthis="$(cd "$(dirname "$0")"&&pwd)"

_list(){
    _ls "$(cygpath -P)"
    _ls "$(cygpath -PA)"
}
_ls(){
    #_infof '%s' "$(cygpath -u "$1")"
    while read -r;do case "$(basename "$REPLY")" in
        desktop.ini);;
        *)_warnf '%s' "$REPLY";;
    esac;done< <(find "$1" -mindepth 1 -maxdepth 1)
}

_kill(){
    sudo "$0" --killelevated
}
_killelevated(){
    :
}

_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -l|--list
	EXAMPLES
	    $0 -l
	EOF
    exit $1
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -l|--list)_list;;
    *)_usage 0;;
esac;shift;done



