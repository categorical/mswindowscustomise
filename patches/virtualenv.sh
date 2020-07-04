#!/bin/bash

virtualenvwin='D:\programs\python3\Scripts\virtualenv.exe'
virtualenvpath=$(cygpath -u "$virtualenvwin")

for i in "$@";do :;done
envdir=$i
envscripts=$envdir/Scripts

"$virtualenvpath" "$@"
[ $? -eq 0 ]||exit 1
[ -d "$envdir" ]||exit 0

_amendactivate(){
    local -r f=$envscripts/activate
    sed -i 's/\r$//' "$f"
    
    # Amends PS1
    local l1='PS1="(`basename \"$VIRTUAL_ENV\"`) ${PS1-}"';l1=$(_esed "$l1")
    local p1='PS1="\[\e]0;\w\a\]\[\e[32m\]\u@\h \[\e[36m\]\w\[\e[0m\]\n\$"';p1=$(_esed "$p1")
    local p2='PS1="\n$PS1"';p2=$(_esed "$p2")
    sed -i "/$l1/i$p1" "$f"
    sed -i "/$l1/a$p2" "$f"

    local l2='export VIRTUAL_ENV';l2=$(_esed "$l2")
    local p3='VIRTUAL_ENV=$(cygpath -u "$VIRTUAL_ENV")';p3=$(_esed "$p3")
    sed -i "/$l2/i$p3" "$f"

     
}
_amendps1(){
    export OLDPS1=$PS1
    # \[...\] encloses non-printing characters
    # \e]0;...\a sets title
    # \w working directory
    # \u username
    # \h hostname
    PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[36m\]\w\[\e[0m\]\n\$'
}
_esed(){
    printf '%s' "$1"|sed 's/[.[\*^$/]/\\&/g'
}


#_amendps1
_amendactivate

