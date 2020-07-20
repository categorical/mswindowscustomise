#/bin/bash



_usage(){
    local -r c0=$'\e[0m'
    local -r c1=$'\e[1m'
    cat <<-EOF
		${c1}SYNOPSIS${c0}
		    $0 ${c1}--list${c0}
		    $0 ${c1}--clear${c0}
		    $0 ${c1}--update${c0}
	EOF
}



thisdir=$(cd "`dirname "$0"`" && pwd )
files="$thisdir/files"
confdir=$HOME


_fs=
_fs(){
    pushd "$files" >/dev/null \
        && mapfile -d '' '_fs'< <(find . -type f -print0) \
        && popd >/dev/null
};_fs

_list(){
    for f in "${_fs[@]}";do
        printf '%s\n' "$f"
    done
}

_update(){
    local p
    pushd "$confdir" >/dev/null \
        && { for f in "${_fs[@]}";do 
            p=`dirname "$f"`
            [ -d "$p" ]||mkdir -p "$p"
            cp "$files/$f" "$f"
        done } \
        && popd >/dev/null
}

_clear(){
    local fa
    for f in "${_fs[@]}";do
        fa=$confdir/$f
        [ ! -f "$fa" ]||(set -x;rm "$fa")
    done 

}

case $1 in
    --list)_list;;
    --clear)_clear;;
    --update)_update;;
    *)_usage;;
esac




