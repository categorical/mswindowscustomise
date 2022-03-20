#/bin/bash

progdir="/cygdrive/d/programs"
readonly bindir="/cygdrive/d/bin"
maintenancedir="/cygdrive/d/devel/mswindowscustomise"
optdir="/cygdrive/d/redev"
devdir="/cygdrive/d/devel"
dopt='/cygdrive/d/opt'

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

#_2bin "$progdir/ruby/bin/ruby.exe" "$bindir/rubywin.exe"
#_2bin "$progdir/ruby/bin/gem.cmd" "$bindir/gem"
#_2bin "$progdir/ruby/bin/bundle.cmd" "$bindir/bundle"
#_2bin "$progdir/ruby/bin/ridk.cmd" "$bindir/ridk"
#_2bin "$progdir/mercurial/hg.exe"

_2bin "$dopt/portablegit/bin/git.exe"
#_2bin "$dopt/emacs/bin/emacs.exe"
_2bin "$dopt/python3/python.exe" "$bindir/pythonwin.exe"
_2bin "$dopt/python3/scripts/pip.exe"
_2bin "$dopt/golang/bin/go.exe"
_2bin "$dopt/golang/bin/gofmt.exe"
_2bin "$dopt/vlc/vlc.exe"
_2bin "$dopt/7z/7z.exe"
_2bin "$dopt/protoc/bin/protoc.exe"
_2bin "$dopt/virtualbox/virtualbox.exe"
_2bin "$dopt/virtualbox/vboxmanage.exe"


#_2bin "$progdir/python3/scripts/virtualenv.exe" "$bindir/virtualenvwin"
#_2bin "$progdir/jdk/bin/java.exe"
#_2bin "$progdir/jdk/bin/javac.exe"
#_2bin "$progdir/jdk/bin/jmap.exe"
#_2bin "$progdir/autohotkey/autohotkeyu64.exe" "$bindir/ahk"
#_2bin "$progdir/nssm/win64/nssm.exe" "$bindir/nssm"

_2bin "$maintenancedir/extensa/patches/vscode.sh" "$bindir/vscode"
_2bin "$dopt/vscode/bin/code" "$bindir/code"
#_2bin "$dopt/vscode/bin/codium" "$bindir/code"
#_2bin "$maintenancedir/extensa/patches/vscode.sh" "$bindir/code"
_2bin "$maintenancedir/extensa/misc/edithosts.sh" "$bindir/hosts"
_2bin "$maintenancedir/extensa/misc/rubbish.sh" "$bindir/rubbish"
_2bin "$maintenancedir/extensa/misc/autokeys/autokeys.cmd" "$bindir/autokeys"
_2bin "$maintenancedir/extensa/misc/crlf.sh" "$bindir/crlf"
_2bin "$maintenancedir/extensa/misc/touchsh.sh" "$bindir/touchsh"
_2bin "$maintenancedir/extensa/misc/iselevated.sh" "$bindir/iselevated"
_2bin "$maintenancedir/extensa/patches/emacs.sh" "$bindir/emacs"
#_2bin "$maintenancedir/patches/scriptruby.sh" "$bindir/ruby"
_2bin "$maintenancedir/extensa/patches/scriptpython.sh" "$bindir/python"
_2bin "$maintenancedir/extensa/patches/virtualenv.sh" "$bindir/virtualenv"
_2bin "$maintenancedir/backlog/virtualenv_dev/virtualenv_dev.sh" "$bindir/virtualenv_dev"
#_2bin "$maintenancedir/extensa/patches/msvc.sh" "$bindir/msvc"
_2bin "$maintenancedir/patches/msvc.sh" "$bindir/msvc"
#_2bin "$maintenancedir/patches/mvn.sh" "$bindir/mvn"

#_2bin 'C:\Program Files (x86)\Microsoft Office\Office14\excel.exe'
_2bin 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe'
_2bin 'C:\Program Files (x86)\MSBuild\14.0\Bin\msbuild.exe'

_2bin '/cygdrive/c/windows/system32/pnputil.exe'
_2bin '/cygdrive/c/windows/system32/dism.exe'




_2bin "$maintenancedir/misc/restartexplorer.bat" "$bindir/restartexplorer"
_2bin "$maintenancedir/patches/sudo.sh" "$bindir/sudo"
_2bin "$maintenancedir/xps/misc/hex2dec"


_2bin "$maintenancedir/misc/msversion.sh" "$bindir/msversion"
_2bin "$maintenancedir/misc/msmod.sh" "$bindir/msmod"
_2bin "$maintenancedir/backlog/robo.sh" "$bindir/robo"
_2bin "$maintenancedir/backlog/md5sums.sh" "$bindir/md5sums"
_2bin "$maintenancedir/backlog/uninstallstrings.sh" "$bindir/uninstallstrings"


_2bin "$devdir/winaries/mssuspend/bin/mssuspend.exe" "$bindir"
_2bin "$devdir/winaries/secho/bin/secho.exe" "$bindir"
_2bin "$devdir/githubrepositories/gitapi"
_2bin "$devdir/xcustomise/backlog/gitssh.sh" "$bindir/gitssh"
_2bin "$devdir/xcustomise/backlog/gitsave.sh" "$bindir/gitsave"
_2bin "$devdir/msmaintenance/opt/steam.sh" "$bindir/steam"
_2bin "$devdir/msmaintenance/opt/rtss.sh" "$bindir/rtss"
_2bin "$devdir/msmaintenance/opt/msiafterburner.sh" "$bindir/msiafterburner"
_2bin "$optdir/installyoutubedl/dltube"
_2bin "$optdir/mstools/installmsrdp/win/wfreerdp.sh"
_2bin "$dopt/wfreerdp/wfreerdp.exe"
_2bin "$optdir/mstools/installmssqlc/mssqlc" "$bindir/mssqlc"


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


