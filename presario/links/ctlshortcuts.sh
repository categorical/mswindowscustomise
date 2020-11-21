#/bin/bash

thisdir=$(cd "$(dirname "$0")" && pwd)



spathw=$(cygpath -w "$thisdir/uacshortcuts.vbs")

_searchdir=$(cygpath -u "$ProgramData/Microsoft/Windows/Start Menu/Programs/_search")

_clearsearchdir(){
    if [ -d "$_searchdir" ];then
        (set -x;rm -rf "$_searchdir")
    fi
}

_updatesearchdir(){
    cscript "$spathw"
}


_usage(){
    local c0=$'\e[0m'
    local c1=$'\e[1m'
    cat <<-EOF
	${c1}SYNOPSIS${c0}
	    $0  ${c1}--clear${c0}
	    $0  ${c1}--update${c0}
	EOF

}


case $1 in
    --clear)
    _clearsearchdir
    ;;
    --update)
    _updatesearchdir
    ;;
    *)_usage;;
esac



