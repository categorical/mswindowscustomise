#!/bin/bash


_include=('*.bat' '*.sh')

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

_run(){
    [ -e "$1" ]||exit 1
    _find "$1"|xargs -0 -I{} bash -c "printf '%s\n' {};sed -i {} -e 's/\$//g'"
}

_usage(){
    cat<<-EOF
	SYNOPSIS:
	    $0 FILE|DIRECTORY
	EOF
}

case "$1" in
    -h|--help)_usage;;
    *)_run "$1";;
esac

