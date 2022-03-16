#!/bin/bash
set -euo pipefail
#_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
#_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
#_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
#_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
#dthis="$(dirname "$(readlink -f "$0")")"
dthis="$(cd "$(dirname "$0")"&&pwd)"
_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -h
	EOF
    exit $1
}

_list(){
    
    local i=0
    local cr=
    local u=
    while IFS= read -r;do
        [ "$cr" = 't' ]&&{ printf '\n|%4d|' "$i";cr=;((++i));}
        [ -z "$REPLY" ]&&{ cr='t';continue;}
        #local k="$(awk -F: '{print $1}'<<<"$REPLY")"
        #local v="$(awk -F: '{print $2}'<<<"$REPLY")"
        local k="${REPLY%%:*}"
        #local v="${REPLY#*:}";v="${v// }"
        local v="${REPLY#*:}";v="${v#${v%%[^ ]*}}"
        local w=10
        case "${k,,}" in
            folder*)u="$v";;
            taskname)w=60;;&
            next*)w=20;;&
            hostname);;
            status);;&
            logon*);;
            #info)w=60;;&
            info)printf '\e[31m%60s\e[0m|' "${v:0:60}";w=31;v="$u";;&
            *)printf "%-${w}s|" "${v:0:$w}";;
        esac
    done< <(schtasks /query /fo list|sed 's/\x0d$//')
    echo
}

_listsort(){
    _list|grep -iv 'disabled'|awk -F'|' '{print $5,$0}'|sort|cut -f2- -d'|'
}

_kill(){
    local v="$1"
    sudo schtasks /change /tn "$1" '/disable'
}
_spare(){
    local v="$1"
    sudo schtasks /change /tn "$1" '/enable'
}

declare -a vs=(
    '\Microsoft\Windows\Windows Error Reporting\QueueReporting'
    '\Microsoft\Windows\WindowsUpdate\Scheduled Start'    
)

_kk(){
    iselevated ||{ sudo "$0" -kk;return;}
    
    for v in "${vs[@]}";do
        _kill "$v"
    done
}

_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 -l|--list
	    $0 -ls
	EXAMPLES
	    $0 -kk
	    $0 -k '\Microsoft\XblGameSave\XblGameSaveTask'
	    $0 --spare '\Microsoft\XblGameSave\XblGameSaveTask'
	EOF
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -l|--list)_list;;
    -ls)_listsort;;
    -k|--kill)_kill "$2";break;;
    -kk)_kk;;
    --spare)_spare "$2";break;;
    *)_usage 0;;
esac;shift;done


