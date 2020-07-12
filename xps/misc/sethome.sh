#!/bin/bash

f=/etc/nsswitch.conf

_sethome(){
    l='db_home:';l=$(_esed "$l")
    p="db_home: $HOME";p=$(_esed "$p")


    sed -i "/^$l/{h;s/.*/$p/};\${x;/^$/{s//$p/;H;};x}" "$f"
}

 
_esed(){
    printf '%s' "$1"|sed 's/[.[\*^$/]/\\&/g'
} 


_sethome

