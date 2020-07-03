#/bin/bash

progdir="/cygdrive/d/programs"
readonly bindir="/cygdrive/d/bin"
optdir="/cygdrive/d/redev"
maintenancedir="/cygdrive/d/dev/mswindowscustomise"

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

_2bin "$maintenancedir/scriptruby.sh" "$bindir/ruby"
_2bin "$maintenancedir/scriptpython.sh" "$bindir/python"
_2bin "$maintenancedir/virtualenv.sh" "$bindir/virtualenv"

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


