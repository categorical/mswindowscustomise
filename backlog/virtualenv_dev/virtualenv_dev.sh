#!/bin/bash
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}

dthis="$(dirname "$(readlink -f "$0")")"
#dthis="$(cd "$(dirname "$0")"&&pwd)"

for v in "$@";do :;done;denv="$v"
_pip="$denv/Scripts/pip3.exe"
_virtualenv=virtualenv

if [ ! -d "$denv" ];then
    "$_virtualenv" "$@"
    [ $? -eq 0 ]||exit 1
fi

[ -f "$_pip" ]||exit 1
"$_pip" install -r "$(cygpath -w "$dthis/requirements.txt")"

# vscode needs: autopep8, pylint
#

