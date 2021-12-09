#!/bin/bash


progdir='/cygdrive/d/programs'
dopt='/cygdrive/d/opt'
f="$dopt/vscode/code.exe"
#[ -f "$f" ]||f="$dopt/vscode/vscodium.exe"

proxy=${http_proxy}

if [ -z "$proxy" ];then
    "$f" "$@" 2>&1 >/dev/null &
else
    "$f" --proxy-server="${proxy/:\/\//=}" "$@" 2>&1 >/dev/null &
fi




