#!/bin/bash
set -eu
msvc='C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat'
# VsDevCmd.bat:239
# When the output is redirected, this call infests the fd longer, thus blocks.
export VSCMD_SKIP_SENDTELEMETRY='telenimei'
# requirements: vs_buildtools: c++: msvc 'windows 10 sdk'

init(){
case ${amd64-} in t)
msvc='C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat'
esac
}
function _msvcenv()(
    msvcd=$(dirname "$msvc")
    # cd because I don't have a way to double quote spaces to cmd.
    cd "$msvcd"
    cmd /c "$(basename "$msvc") 1>&2&&printenv "$@""
)
function _setmsvcenv(){
    local n=()
    while IFS= read -r -d $'\0';do
        n+=("$REPLY")
    done < <(_msvcenv -0)
    for i in "${!n[@]}";do
    local v=${n[$i]}
    local k=${v%%=*};v=${v#*=}
    case $k in
        PROMPT*|'!'*|*'(x86)'|BASH_FUNC_*);;
        *)_setv "$k" "$v"
    esac;done
}
function _setv(){
    local v="$2"
    local k="$1"
    if [[ $k =~ ^[0-9] ]];then
        # environment variable name does not begin with a digit
        return 1
    fi
    #printf '%s=%s\n' "$k" "$v"
    export "$k"="$v"
}
_ps1(){
    cat <<-1
	PS1='\[\e]0;\w\a\]\n\[\e[36m\](msvc) \[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
	1
}
_provision(){
    # n.b. --login causes .bash_profile to be read one more time:
    # aliases and functions, etc are loaded,
    # but exports are unintentional if non idempotent, e.g. PATH=$PATH:foo.
    # _setmsvcenv && bash --login -i
    # n.b. --rcfile and --login are mutually exclusive.
    if [ $# -eq 0 ];then
    _setmsvcenv && bash --rcfile <(cat "$HOME/.bash_profile";_ps1;cat '/etc/profile.d/vim.sh') -i
    else
    _setmsvcenv && "$@"
    fi
}
main(){ usage(){ cat<<1
SYNOPSIS
    $0 --env [-amd64]
    $0 -h
    $0
1
exit $1;}
while [ $# -gt 0 ];do case $1 in
-amd64)amd64=t;;-h)usage 0;;*)n+=("$1")
esac;shift;done;set -- "${n[@]}";init
case ${1-} in
--env|-env)_msvcenv|grep -v ^LESS_TERMCAP_;;
*)_provision "$@"
esac
};main "$@"
