#/!bin/bash

thisdir=$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)
thisdirw=$(cygpath -w "$thisdir")

tdirw=$thisdirw'\temporary'
parsedm=$tdirw'\machineparsed.txt'
builtm=$tdirw'\machinebuilt.pol'

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
    lgpo /parse /m "$1" >"$parsedm"
}
_pack(){
    lgpo /r "$1" /w "$2" 
}
_export(){
    sudo lgpo /b "$tdirw"
}
_importm(){
    sudo lgpo /m "$builtm"
}

[ -d "$tdirw" ]||mkdir "$tdirw"
 _export \
    && fm=$(_findpolm "$tdirw") \
    && _unpackm "$fm" \
    && _pack "$parsedm" "$builtm" \
    && _importm
[ ! -d "$tdirw" ]||(set -x;rm -r "$tdirw")



