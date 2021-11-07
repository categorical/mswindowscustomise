#!/bin/bash

executable=/cygdrive/d/opt/python3/python.exe

scriptpath=$1
if [ -f "$scriptpath" ];then
    scriptpath=$(cygpath -w "$scriptpath")
fi

exec "$executable" "$scriptpath" "${@:2}"

