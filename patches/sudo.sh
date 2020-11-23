#!/bin/bash


 
# 1. Escapes every ': \'
# 2. single quotes every remaining substring.
# 
_quote(){
    printf '%s' "$1"|sed $'s/\'/\'\\\\\'\'/g;s/\(.*\)/\'\\1\'/'
}

# Escaping every character does not work right.
_escape(){
    printf '%s' "$1"|sed 's/\(.\)/\\\1/g'
}

# 1. Escapes any " by another ": "",
# 2. then double quotes the whole string.
# It seems that in 2 an opening double quote works alone, even without an ending quote.
# I think cmd passes everything as it is to bash, except escaped double quotes,
# then bash.exe makes an extra step of sanitising the input before evaluation.
_doublequote(){
    printf '%s' "$1"|sed 's/"/""/g;s/\(.*\)/"\1/'
}
    

# Single quotes every argument.
for arg;do
    set -- "$@" "$(_quote "$arg")"
    shift
    :
done

args="$*"
#args+=';sleep 60'
args="$(_doublequote "$args")"
#echo "$args"

cygstart --action=runas --wait \
    bash --login -c "$args"




