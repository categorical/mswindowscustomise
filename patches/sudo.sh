#!/bin/bash


 
_e(){
    printf '%s' "$1"|sed 's/[\]/\\&/g'
}
_e3(){
    printf '%s' "$(_e "$(_e "$(_e "$1")")")"
}

_quote(){
    printf '%s' "$1"|sed $'s/\'/\'\\\\\'\'/g;s/\(.*\)/\'\\1\'/'
}
x=\'\ \'
d=
for arg;do
    set -- "$@" "$(_quote "$arg")"
    d+="$(_quote "$arg")$x"
    shift
    :
done
d=${d%"$x"}
echo "$*"
echo "d: $d"
a="$d$x&&${x}sleep${x}1"
#b="$(_quote "$a")"
#c=\""$a"\"
echo "a: $a"
#echo "b: $b"
#echo "c: $c"


#bash -c "echo $a"
#bash -c "echo $b"
#bash -c "echo $c"
#bash -c "$a"
#bash -c "$b"

#cygstart --action=runas --wait \
#    bash --login -c "'""$(_e "$*")""'"
#cygstart --wait cmd /c "echo $b"
echo 222

#cygstart --wait cmd /c "echo $c"

cygstart --wait \
    bash --login -c "$a"



