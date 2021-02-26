#!/bin/bash

msvc='C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat'
#msvc='C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat'
# VsDevCmd.bat:239
# When the output is redirected, this call infests the fd longer, thus blocks.
export VSCMD_SKIP_SENDTELEMETRY='telenimei'

function _msvcenv()(
    msvcd=$(dirname "$msvc")
    # cd because I don't have a way to double quote spaces to cmd.
    cd "$msvcd" \
        && cmd /c "$(basename "$msvc") 1>&2 && printenv"
)

function _setmsvcenv(){
    local vs=()
    while IFS= read -r l;do
        vs+=("$l")
    done < <(_msvcenv)
    for i in "${!vs[@]}";do
        local v=${vs[$i]}
        local k=${v%%=*};v=${v#*=}
        case $k in
            'PROMPT'*);;
            '!'*);;
            *'(x86)')
                ;;
            *)_setv "$k" "$v";;
        esac
    done
}

function _setv(){
    local v="$2"
    local k="$1"
    #printf '%s=%s\n' "$k" "$v"
    export "$k"="$v"
}



_usage(){
    cat <<-EOF
	SYNOPSYS:
	    $0 -h
	    $0 --env
	    $0
	EOF

}

_ps1(){
    cat <<-EOF
	PS1='\[\e]0;\w\a\]\n\[\e[36m\](msvc) \[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$'
	EOF
}
_provision(){
    # n.b. --login causes .bash_profile to be read one more time:
    # aliases and functions, etc are loaded,
    # but exports are unintentional if non idempotent, e.g. PATH=$PATH:foo.
    # _setmsvcenv && bash --login -i
    # n.b. --rcfile and --login are mutually exclusive.
    _setmsvcenv && bash --rcfile <(cat "$HOME/.bash_profile";_ps1) -i
}

case $1 in
    --env)_msvcenv;;
    -h)_usage;;
    *)_provision;;
esac





