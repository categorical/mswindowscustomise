#/bin/bash

progdir='/cygdrive/d/Program Files'
readonly bindir='/cygdrive/d/dev/bin'
maintenancedir='/cygdrive/d/dev/mswindowscustomise'
optdir='/cygdrive/d/redev'
devdir='/cygdrive/d/dev'


function _2bin(){
	local -r f=$1
	local -r dest=${2:-$bindir}
	[ ! -f "$f" ] || (set -x;ln -sf "$f" "$dest")
}

function _bindir(){
    [ -d "$bindir" ]||mkdir "$bindir"
}

function _update(){
    _bindir

_2bin "$progdir/Python/Python36/python.exe" "$bindir/pythonwin.exe"
_2bin "$progdir/Python/Python36/Scripts/pip.exe"
_2bin "$progdir/Python/Python36/Scripts/virtualenv.exe" "$bindir/virtualenvwin"
_2bin "$maintenancedir/xps/patches/scriptpython.sh" "$bindir/python"
_2bin "$maintenancedir/xps/patches/virtualenv.sh" "$bindir/virtualenv"

_2bin "$maintenancedir/misc/restartexplorer.bat" "$bindir/restartexplorer"
_2bin "$maintenancedir/xps/misc/hex2dec"



_2bin "$devdir/githubrepositories/gitapi"
_2bin "$devdir/windowsvolumeosd/build/install/windowsvolumeosd/bin/windowsvolumeosd"



}

function _clear(){
    if [ -d "$bindir" ];then
        (set -x;rm -r "$bindir")
    fi
}

_usage(){
    local -r c1="$(printf '%b' '\033[1m')"
    local -r c0="$(printf '%b' '\033[0m')"
    cat <<-EOF
	${c1}SYNOPSIS${c0}
	    $0 ${c1}--update${c0}
	    $0 ${c1}--clear${c0}
	EOF
}

arg="${1:---update}"
case $arg in
    --update)_update;;
    --clear)_clear;;
    *)_usage;;
esac


