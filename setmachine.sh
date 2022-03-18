#!/bin/bash
set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_onexit(){ printf 'exit: %d\n' $? >&2;};trap _onexit EXIT

dthis=$(cd "$(dirname "$0")" && pwd)
droot=$(cd "$dthis/.." &&pwd)
dmaintenance="$droot/msmaintenance"
dcustomise="$droot/mswindowscustomise"
dcustomisex="$droot/xcustomise"

_ex15(){
    local v='ex15'
    [ "$(hostname)" = "$v" ]||"$dmaintenance/winfiles/sethostname.sh" "$v"

    "$dcustomisex/0scripts/09conf.sh" --sshd
}

_desk2(){
    local v='desk2'
    [ "$(hostname)" = "$v" ]||"$dmaintenance/winfiles/sethostname.sh" "$v"

    #"$dcustomisex/0scripts/09conf.sh" --sshd
}



_set(){
    
    "$dmaintenance/winfiles/env.sh" --set
    "$dcustomise/extensa/regs/regs.bat" 
    "$dcustomise/extensa/links/slinks.sh"
    eval "$("$dmaintenance/winfiles/env.sh" --setbash)"
    
    "$dcustomise/misc/sethome.sh"
    "$dcustomisex/0scripts/homevcs/homevcs_nt.sh" --link
    "$dcustomisex/0scripts/homevcs/private.sh" --restore||:
    
    _packages
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
    local f="$dmaintenance/winfiles/deactivate.sh"
    if ! "$f" --activated;then "$f" --activate --yes;fi;f=

    if ! sc query cygsshd|grep -i 'running'>/dev/null;then
    "$dcustomise/misc/cygsshd.sh" --setup;fi
    "$dcustomise/misc/cygsshd.sh" --configure
    
    
    "$dmaintenance/winfiles/msmod_ssh.sh" -s
}

_packages(){
    "$dmaintenance/opt/console2.sh" --fromscratch
    "$dmaintenance/opt/portablegit.sh" --fromscratch
    "$dmaintenance/opt/font.sh" --fromscratch 
    "$dmaintenance/opt/sharpkeys.sh" --fromscratch
    "$dmaintenance/opt/python3.sh" --fromscratch
    "$dmaintenance/mozilla/install.sh" --fromscratch
    
}


_clicking(){
    local c0="$(printf '\e[0m')";local c1="$(printf '\e[31m')"
    local c2="$(printf '\e[32m')";local c3="$(printf '\e[33m')"
    cat<<EOF
1 gpedit.msc IMMEDIATELY after install
    - enable    "disable ${c1}audoblay${c0}"
    - enable    "disable ${c2}antibirus${c0}"
    - disable   "${c3}audoupbate${c0}"
2 to stop microsoft from reopening its things
    - settings
      sign in options
      "use my sign in info to audomatically finish setting up my device and reopen my apps after an update or restart"
EOF
}

_usage(){
    cat<<-EOF
	SYNOPSIS:
	    $0 --set
	    $0 --clicking
	EOF
    exit $1
}


[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    --ex15)_ex15;;
    --desk2)_desk2;;
    --set)_set;;
    --setelevated)_setelevated;;
    --clicking)_clicking;;
    *)_usage 0;;
esac;shift;done

