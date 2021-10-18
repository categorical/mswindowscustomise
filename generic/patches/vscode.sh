#!/bin/bash


progdir='/cygdrive/d/programs'
f="$progdir/vscode/code.exe"

proxy=${http_proxy}

_start(){
if [ -z "$proxy" ];then
    #"$f" "$@" 2>&1 >/dev/null &
    cygstart "$f" "$@"
else
    "$f" --proxy-server="${proxy/:\/\//=}" "$@" 2>&1 >/dev/null &
    
fi
}

_stop(){
    taskkill /im code.exe /f
    :
}

case $1 in
    --stop)_stop;;
    *)_start "$@";;
esac



