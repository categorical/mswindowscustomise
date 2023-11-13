#!/bin/bash
set -eu
_onexit(){ printf 'exit: %d\n' $?>&2;};trap _onexit EXIT
_inf(){ printf '\e[36mI: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;}
_Err(){ printf '\e[31mE: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;exit 1;}
thisdir=$(cd "$(dirname "$0")" && pwd)

id="$(id -nu)"
declare -a pfx=(
"$HOME:/home/$id"
"/cygdrive/d:/home/$id"
)
rmt=outt
_rx(){ _setvar "$1"
    local b="$out/$nam"
    echo "[ -e '$b' ]"|ssh "$rmt" bash||_Err 'not found %s' "$b"
    rsync -rv --files-from=<(echo "$nam") "$rmt:$out/" "$dir/"
}
_tx(){ _setvar "$1"
    local b="$1";[ -e "$b" ]||_Err 'not found %s' "$b"
    rsync -rv --files-from=<(echo "$nam") "$dir/" "$rmt:$out/"
}
_setvar(){
    local s="$(realpath -sm "$1")"
    local u;for u in "${pfx[@]}";do
        local c="${u%%:*}" b="${u#*:}"
        case $s in $c/*)
            dir="$c"
            out="$b"
            nam="${s#$c/}"
            declare -p dir out nam
            return
        esac
    done
    _Err 'not implemented %s' "$s"
}
_main(){ _usage(){ cat<<-EOF
	SYNOPSIS:
	    $0 --rx|--tx FLE|DIR
	OPTION:
	    -rx    recevice
	    -tx    send to host
	EOF
    exit $1;}
    declare -a a;while [ $# -gt 0 ];do case $1 in
        *)a+=("$1")
    esac;shift;done;set -- "${a[@]}"
    [ $# -gt 0 ]||_usage 1;while [ $# -gt 0 ];do case $1 in
        -rx|--rx)shift;_rx "$1";;
        -tx|--tx)shift;_tx "$1";;
        -h)_usage 0;;*)_usage 1
    esac;shift;done
};_main "$@"
