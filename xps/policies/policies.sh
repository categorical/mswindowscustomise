#/!bin/bash

thisdir=$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)
thisdirw=$(cygpath -w "$thisdir")

tdirw=$thisdirw'\temporary\'
parsedm='machineparsed.txt'
builtm='machinebuilt.pol'

edirw=$thisdirw'\export\'
idirw=$thisdirw'\import\'


machinepolpathw='C:\Windows\System32\GroupPolicy\Machine\Registry.pol'


_findpolm(){
    local d="$1"
    local f
    #f=$machinepolpathw
    f=$(find "$d" -maxdepth 5 -type f -ipath '*machine*' -name '*.pol' -print|head -n1)
    f=$(cygpath -w "$f")
    [ -f "$f" ]||exit 1
    printf '%s' "$f"
}

_unpackm(){
    lgpo /parse /m "$1" >"$2"
}
_pack(){
    lgpo /r "$1" /w "$2" 
}
_export(){
    sudo lgpo /b "$1"
}
_importm(){
    sudo lgpo /m "$1"
}

_workflow(){
[ -d "$tdirw" ]||mkdir "$tdirw"
 _export "$tdirw" \
    && { local fm;fm=$(_findpolm "$tdirw");} \
    && _unpackm "$fm" "$tdirw$parsedm"\
    && _pack "$tdirw$parsedm" "$tdirw$builtm" \
    && _importm "$tdirw$builtm"
[ ! -d "$tdirw" ]||(set -x;rm -r "$tdirw")
}


_usage(){
    local c0=$'\e[0m'
    local c1=$'\e[1m'
    cat<<-EOF
	${c1}SYNOPSIS${c0}
	    $0 ${c1}--export${c0}
	    $0 ${c1}--import${c0}
	EOF
}

_backupm(){
    [ -d "$edirw" ]||mkdir "$edirw" \
        && _export "$edirw" \
        && { local fm;fm=$(_findpolm "$edirw");} \
        && _unpackm "$fm" "$edirw$parsedm" \
        && if [ ! -f "$idirw$parsedm" ];then
            [ -d "$idirw" ]||mkdir "$idirw" \
                && cp "$edirw$parsedm" "$idirw"
        fi \
        && find "$edirw" -maxdepth 1 -mindepth 1 -type d -print0 \
            |xargs -0 -n1 bash -c 'set -x;rm -r "$0"'
}

_persistm(){
    local fm=$idirw$parsedm
    [ -f "$fm" ]||exit 1
    _pack "$idirw$parsedm" "$idirw$builtm" \
        && _importm "$idirw$builtm" \
        && (set -x;rm "$idirw$builtm") \
        #&& gpupdate /force
 
}

_clear(){
    (set -x;rm -rf "$idirw")
    (set -x;rm -rf "$edirw")
}


case $1 in
    --export)_backupm;;
    --import)_persistm;;
    --clear)_clear;;
    --workflow)_workflow;;
    *)_usage;;
esac















