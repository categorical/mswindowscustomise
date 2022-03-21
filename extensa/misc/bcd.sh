#!/bin/bash


set -euo pipefail
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[31merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_abort(){ _errorf 'abort %s' "${FUNCNAME[1]}";exit 1;}

_legacy(){
    _abort
# /boot/efi/EFI contains boot loaders.
# bcdedit and grub-install seems to be managing data beyond that EFI folder,
# both are able to set UEFI firmware settings regarding the needed .efi path.
# Windows is eager but messed the settings.
# BIOS/UEFI errors out and boots from disk's default settings.

# Does chaning .efi path here saves Windows from touching the firmware?
sudo bash -c 'bcdedit /set {bootmgr} path '\''\EFI\ubuntu\grubx64.efi'\'';bcdedit'
}

_killrecovery(){
    _abort    

    _bcdedit '/set {default} bootstatuspolicy ignoreallfailures'
    #_bcdedit '/set {default} bootstatuspolicy displayallfailures'
    _bcdedit '/set {default} recoveryenabled no'
    _bcdedit '/set {default} restartonfailure yes'

    # if memory serves right, the combination is to
    # set microsoft reboot on stop error without "features"
}

# applicable if there are multiple boot entries
# text mode, not showing unless shift key during boot
_menu(){ 
    _bcdedit '/set {default} bootmenupolicy legacy';
    _bcdedit '/timeout 0'
}
_menuunset(){ 
    _bcdedit '/set {default} bootmenupolicy standard';
    _bcdedit '/deletevalue {bootmgr} timeout'||:
}

# msconfig.exe:Boot:No GUI boot
# removes the throbber, i.e. animated dots on the microsoft splash screen
_splash(){ _bcdedit '/set {default} quietboot yes';}
_splashunset(){ _bcdedit '/set {default} quietboot no';}

_entry(){ _bcdedit /enum '{default}';}
_bcdedit(){ declare -a args=(bcdedit "$@");sudo bash -c "${args[*]}";}

_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 -b|--bcdedit
	    $0 -e|--entry
	EXAMPLES
	    $0 -b       bcdedit
	    $0 -e       shows "{default}"
	    $0 -m       no gui bootmenu
	    $0 -s       no splash animation
	    $0 --splashunset
	    $0 --menuunset
	    $0 -s -m    
	EOF
    exit $1
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -m|--menu)_menu;;
    -s|--splash)_splash;;
    -b|--bcdedit)_bcdedit "${@:2}";break;;
    -e|--entry)_entry;;
    --splashunset)_splashunset;;
    --menuunset)_menuunset;;
    *)_usage 0;;
esac;shift;done



