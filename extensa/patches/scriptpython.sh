#!/bin/bash
executable=/cygdrive/d/opt/python3/python.exe
case $0 in *py2)
executable=/cygdrive/d/opt/python2/python.exe
esac
scriptpath=$1
if [ -f "$scriptpath" ];then
    scriptpath=$(cygpath -w "$scriptpath")
fi
exec "$executable" "$scriptpath" "${@:2}"
