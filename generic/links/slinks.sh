#/bin/bash

progdir="/cygdrive/d/programs"
readonly bindir="/cygdrive/d/bin"
maintenancedir="/cygdrive/d/zdev/mswindowscustomise"
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

#_2bin "$progdir/ruby/bin/ruby.exe" "$bindir/rubywin.exe"
#_2bin "$progdir/ruby/bin/gem.cmd" "$bindir/gem"
#_2bin "$progdir/ruby/bin/bundle.cmd" "$bindir/bundle"
#_2bin "$progdir/ruby/bin/ridk.cmd" "$bindir/ridk"
#_2bin "$progdir/mercurial/hg.exe"

_2bin "$progdir/portablegit/bin/git.exe"
#_2bin "$progdir/emacs/bin/emacs.exe"
_2bin "$progdir/python3/python.exe" "$bindir/pythonwin.exe"
_2bin "$progdir/python3/scripts/pip.exe"
_2bin "$progdir/golang/bin/go.exe"
_2bin "$progdir/protoc/bin/protoc.exe"
_2bin "$progdir/vlc/vlc.exe"
_2bin "$progdir/7z/7z.exe"
_2bin 'C:\Program Files (x86)\Microsoft Office\Office14\excel.exe'
_2bin 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe'
_2bin 'C:\Program Files (x86)\MSBuild\14.0\Bin\msbuild.exe'
_2bin 'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64\wsdl.exe'
_2bin 'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\x64\svcutil.exe'
#_2bin 'C:\Program Files\dotnet\dotnet.exe'
#_2bin "$progdir/wfreerdp/wfreerdp.exe"

#_2bin "$progdir/python3/scripts/virtualenv.exe" "$bindir/virtualenvwin"
#_2bin "$progdir/jdk/bin/java.exe"
#_2bin "$progdir/jdk/bin/javac.exe"
#_2bin "$progdir/jdk/bin/jmap.exe"
#_2bin "$progdir/autohotkey/autohotkeyu64.exe" "$bindir/ahk"
#_2bin "$progdir/redis/redis-cli.exe"

_2bin "$maintenancedir/generic/patches/emacs.sh" "$bindir/emacs"
_2bin "$maintenancedir/generic/patches/vscode.sh" "$bindir/vscode"
_2bin "$progdir/vscode/bin/code" "$bindir/code"
_2bin "$maintenancedir/generic/misc/edithosts.sh" "$bindir/hosts"
_2bin "$maintenancedir/generic/misc/rubbish.sh" "$bindir/rubbish"
_2bin "$maintenancedir/generic/misc/crlf.sh" "$bindir/crlf"
_2bin "$maintenancedir/generic/patches/msvc.sh" "$bindir/msvc"

#_2bin "$maintenancedir/patches/scriptruby.sh" "$bindir/ruby"
_2bin "$maintenancedir/generic/patches/scriptpython.sh" "$bindir/python"
_2bin "$maintenancedir/generic/patches/virtualenv.sh" "$bindir/virtualenv"
#_2bin "$maintenancedir/patches/mvn.sh" "$bindir/mvn"

_2bin "$maintenancedir/misc/restartexplorer.bat" "$bindir/restartexplorer"
_2bin "$maintenancedir/patches/sudo.sh" "$bindir/sudo"
_2bin "$maintenancedir/generic/misc/hex2dec"
_2bin "$maintenancedir/misc/msmod.sh" "$bindir/msmod"


#_2bin "$devdir/githubrepositories/gitapi"
#_2bin "$optdir/installyoutubedl/dltube"
_2bin "$optdir/mstools/installmsrdp/wfreerdp/wfreerdp.exe"
_2bin "$optdir/mstools/installmssqlc/mssqlc" "$bindir/mssqlc"
_2bin "$optdir/mstools/installlitec/litec" "$bindir/litec"

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


