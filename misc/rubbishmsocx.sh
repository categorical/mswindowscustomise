#/bin/bash


thisdir=$(cd "$(dirname "$0")" && pwd)
rubbishdir=$thisdir/rubbishmsocx.d
destdirw='C:\Windows\SysWOW64'

declare -a rubbishnames=()
rubbishnames+=(MSCOMCT2.OCX)
rubbishnames+=(comdlg32.ocx)

_usage(){
    cat <<-EOF
	SYNOPSIS:
	    $0 --install
	    $0 --clean
	EOF
}


_installall(){
    for r in "${rubbishnames[@]}";do
        _install "$r"
    done

}

_install(){
    local rubbishw=$(_rubbishw "$1")
    [ -f "$rubbishdir/$1" ] \
        && sudo cp "$rubbishdir/$1" "$destdirw" \
        && sudo regsvr32 "$rubbishw"
}

_cleanall(){
    for r in "${rubbishnames[@]}";do
        _clean "$r"
    done

}

_clean(){
    local rubbishw=$(_rubbishw "$1")
    regsvr32 /u "$rubbishw"
    [ ! -f "$rubbishw" ] || (set -x; rm "$rubbishw")
}

_rubbishw(){
    printf '%s' "$(cygpath -w "$destdirw/$1")"
}


case $1 in
    --install)_installall;;
    --clean)_cleanall;;
    *)_usage;;
esac



