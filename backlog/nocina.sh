#!/bin/bash
set -eu
trap 'echo exit $?>&2' EXIT
say(){ printf '\e[36mI: \e[0m%s\n' "$1">&2;}
die(){ printf '\e[31mE: \e[0m%s\n' "$1">&2;exit 1;}
thisdir=$(cd "$(dirname "$0")" && pwd)
nt1='hkcu\software\microsoft\windows\currentversion\explorer\mycomputer\namespace'
nocina(){
u="$nt1\\{679f137c-3162-45da-be3c-2f9c3d093f64}"
if reg query "$u";then reg delete "$u" /f;fi
}
main(){ usage(){ cat<<1
$0 -nocina
1
exit $1;}
[ $# -gt 0 ]||usage 1;while [ $# -gt 0 ];do case $1 in
-nocina)nocina;;-h)usage 0;;*)usage 1
esac;shift;done
};main "$@"
