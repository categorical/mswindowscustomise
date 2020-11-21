#/bin/bash

progdir="/cygdrive/d/programs"
readonly bindir="/cygdrive/d/bin"
maintenancedir="/cygdrive/d/dev/mswindowscustomise"
optdir="/cygdrive/d/redev"
devdir="/cygdrive/d/dev"


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

_2bin "$progdir/ruby/bin/ruby.exe" "$bindir/rubywin.exe"
_2bin "$progdir/ruby/bin/gem.cmd" "$bindir/gem"
_2bin "$progdir/ruby/bin/bundle.cmd" "$bindir/bundle"
_2bin "$progdir/ruby/bin/ridk.cmd" "$bindir/ridk"
_2bin "$progdir/mercurial/hg.exe"

_2bin "$progdir/git/bin/git.exe"
_2bin "$progdir/emacs-26.3/bin/emacs.exe"
_2bin "$progdir/python3/python.exe" "$bindir/pythonwin.exe"
_2bin "$progdir/python3/scripts/pip.exe"
_2bin "$progdir/python3/scripts/virtualenv.exe" "$bindir/virtualenvwin"
_2bin "$progdir/jdk/bin/java.exe"
_2bin "$progdir/jdk/bin/javac.exe"
#_2bin "$progdir/jdk/bin/jmap.exe"


_2bin "$maintenancedir/patches/scriptruby.sh" "$bindir/ruby"
_2bin "$maintenancedir/patches/scriptpython.sh" "$bindir/python"
_2bin "$maintenancedir/patches/virtualenv.sh" "$bindir/virtualenv"
_2bin "$maintenancedir/patches/mvn.sh" "$bindir/mvn"

_2bin "$maintenancedir/misc/restartexplorer.bat" "$bindir/restartexplorer"
_2bin "$maintenancedir/patches/sudo.sh" "$bindir/sudo"
_2bin "$maintenancedir/xps/misc/hex2dec"



_2bin "$devdir/githubrepositories/gitapi"
_2bin "$optdir/installyoutubedl/dltube"

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


