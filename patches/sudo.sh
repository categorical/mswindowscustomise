#!/bin/bash


if command -v iselevated &>/dev/null && iselevated;then "$@";exit;fi

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

_messagef(){ local f=$1;shift;printf '\033[96m[%s] %s\033[0m\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$(printf "$f" "$@")";}

    
# Single quotes every argument.
for arg;do
    set -- "$@" "$(_quote "$arg")"
    shift
    :
done


args="cd '$(pwd)'"
args+=";$*"
#args+=';sleep 60'
timeoutsecs=60
args+=";read -t $timeoutsecs -p '$(_messagef \
    "The operation has completed. This window closes after %s seconds." \
    $timeoutsecs)'"
args="$(_doublequote "$args")"
#echo "$args"
cygstart --action=runas --wait \
    bash --login -c "$args"




