#!/bin/bash

msvc='C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat'
mintty=/usr/bin/mintty

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
    printf '%s=%s\n' "$k" "$v"
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

case $1 in
    --env)_msvcenv;;
    -h)_usage;;
    *)_setmsvcenv;;
esac





