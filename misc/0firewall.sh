#!/bin/bash
set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
dthis="$(dirname "$(readlink -f "$0")")"

_set(){
    local f="$dthis/firewalluac.vbs"
    cscript "$(cygpath -w "$f")"
}


_list(){
    local i=0
    local cr=
    declare -A row=()
    
    declare -a us=(
    rulename
    enabled
    direction
    profiles
    #grouping
    localip
    remoteip
    protocol
    localport
    remoteport
    #edgetraversal
    program
    action
    )
    _printrow(){
        cr=;[ ${#row[@]} -gt 0 ]||return 1
        declare -a args=($i);local f='|%4d'
         
        local v w;for u in "${us[@]}";do v="${row[$u]-}";w=2;case "$u" in
            rulename)w=40;;&
            enabled)[ "$arg_enabled" = 't' ]&&case "$v" in No)return 1;;esac;;&
            direction);;&
            profiles)w=16;;&
            *ip);;&
            protocol)case "$v" in TCP|UDP);;*)return 1;;esac;;&
            localport)w=12;;&
            remoteport)w=4;;&
            program)w=16;;&
            action);;&
            *)args+=("${v:0:$w}");f="$f|%-${w}s";;
        esac;done
        printf "$f|\n" "${args[@]}"
    }
    while IFS= read -r;do
        [ "$cr" = 't' ]&&{ cr=;_printrow&&((++i));row=();}
        [ -z "$REPLY" ]&&{ cr='t';continue;}
        local k="${REPLY%%:*}";k="${k,,}";k="${k// }"
        local v="${REPLY#*:}";v="${v#${v%%[^ ]*}}"
        row[$k]="$v"
    done< <(netsh advfirewall firewall show rule name=all verbose|sed 's/\x0d$//')
    echo
}
arg_enabled='t'
_lista(){ arg_enabled=;_list;}

_show(){ netsh advfirewall show currentprofile;}
_showa(){ netsh advfirewall show allprofiles;}

_delete(){
    local v="$1"
    sudo netsh advfirewall firewall delete rule name="$v"
}


_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -s|--show
	    $0 -sa
	    $0 -l|--list
	    $0 -la
	    $0 --delete VALUE
	    $0 --set
	EXAMPLES
	    $0 --set                                    load rules written in another script
	    $0 --delete "deluge bittorrent client"
	    $0 --delete deluge                          another rule
	EOF
    exit $1
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -s|--show)_show;;
    -sa)_showa;;
    --set)_set;;
    -l|--list)_list;;
    -la)_lista;;
    --delete)_delete "$2";break;;
    *)_usage 0;;
esac;shift;done
