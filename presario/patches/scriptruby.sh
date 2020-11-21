#!/bin/bash

executable=/cygdrive/d/programs/ruby/bin/ruby.exe

scriptpath=$1
if [ -f "$scriptpath" ];then
    scriptpath=$(cygpath -w "$scriptpath")
fi

exec "$executable" "$scriptpath" "${@:2}"

