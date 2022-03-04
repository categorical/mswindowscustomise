#!/bin/bash
set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_onexit(){ printf 'exit: %d' $?;};trap _onexit EXIT

dthis=$(cd "$(dirname "$0")" && pwd)
droot=$(cd "$dthis/.." &&pwd)
dmaintenance="$droot/msmaintenance"
dcustomise="$droot/mswindowscustomise"


_set(){
    
    "$dmaintenance/winfiles/env.sh" --set
    "$dcustomise/extensa/regs/regs.bat" 
    "$dcustomise/extensa/links/slinks.sh"
    # TODO: 
    "$dcustomise/misc/sethome.sh"
  
    sudo "$0" --setelevated
       
}
_setelevated(){
    "$dcustomise/extensa/regs/ctluacregs"
    "$dcustomise/extensa/links/ctlshortcuts.sh" --update
    
    "$dmaintenance/winfiles/menu.sh" --set
    "$dmaintenance/winfiles/pol.sh" --restore
    "$dmaintenance/winfiles/ui.sh" --imageset
    "$dmaintenance/winfiles/ui.sh" --textset
    "$dmaintenance/winfiles/hosts.sh" --restore
    "$dmaintenance/winfiles/deactivate.sh" --activate
    

    "$dcustomise/misc/cygsshd.sh"
 
}


_usage(){
    cat<<-EOF
	SYNOPSIS:
	    $0 --set
	EOF
    exit $1
}


[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    --set)_set;;
    --setelevated)_setelevated;;
    *)_usage 0;;
esac;shift;done

