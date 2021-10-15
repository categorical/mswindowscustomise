#!/bin/bash


_include=(
'*.bat' '*.sh' '*.py' '*.el'
'*.css'
'.gitignore' '.hgignore'
)

_find(){
    local names v
    for v in "${_include[@]}";do
        names+=$(printf " -name '%s' -or" "$v")
    done
    if [ -n "$names" ];then
        names=${names%'-or'}
        names=$(printf '\(%s\)' "$names")
    fi
    
    eval find '"$1"' -type f "$names" -print0
}

_lf(){
    [ -e "$1" ]||exit 1
    _find "$1"|xargs -0 -I{} bash -c "printf '%s\n' {};sed -i {} -e 's/\$//g'"
}
_crlf(){
    [ -e "$1" ]||exit 1
    _find "$1"|xargs -0 -I{} bash -c "printf '%s\n' {};sed -i {} -e 's/\$//g'"
}

_usage(){
    cat<<-EOF
	SYNOPSIS:
	    $0 --lf     FILE|DIRECTORY
	    $0 --crlf   FILE|DIRECTORY
	EOF
}

case "${1}" in
    --lf)_lf "$2";;
    --crlf)_crlf "$2";;
    *)_usage;;
esac

