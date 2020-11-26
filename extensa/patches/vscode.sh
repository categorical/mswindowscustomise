#!/bin/bash


progdir='/cygdrive/d/programs'
f="$progdir/vscode/code.exe"

proxy=${http_proxy}

if [ -z "$proxy" ];then
    "$f" "$@"
else
    "$f" --proxy-server="${proxy/:\/\//=}" "$@"
fi




