#!/bin/bash


dthis="$(cd "$(dirname "$0")" && pwd)"
dbin='/cygdrive/d/bin'

_build(){
    msvc bash -c "cd '$dthis' && make build"
}


_install(){
    :
    ln -s "$dthis/bin/mssuspend.exe" "$dbin"
}

_remove(){
    :
    [ ! -L "$dbin/mssuspend.exe" ]||(set -x;rm "$dbin/mssuspend.exe")
}





_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --install
	    $0 --build
	EOF
}



case $1 in
    --install)_install;;
    --remove)_remove;;
    --build)_build;;
    *)_usage;;
esac
