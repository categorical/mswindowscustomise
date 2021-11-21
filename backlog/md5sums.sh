#!/bin/bash
#_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
#_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
#_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
#_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}

dthis="$(cd "$(dirname "$0")"&&pwd)"
vfout='md5sums.txt'

_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -h
	    $0 [--directory] directory
	    $0 --check directory
	EOF
}



_directorydelta(){
    local d="$1"
    local f="$d/$vfout"
    declare -a _vs vsprevious _vsout
    pushd "$d" 2>&1 >/dev/null \
        && while IFS= read -r -d $'\0';do
            _vs+=("$REPLY")
        done < <(find . -type f ! -path "./$vfout" -print0) \
        && popd >/dev/null

    #IFS=$'\n' read -r -a 'existing' -d $'\0' \
    mapfile -t -d $'\n' 'vsprevious' \
        < <([ -f "$f" ]&&sed -n -e 's/^[a-f0-9]\{32\}\s\+[*]\?//p' "$f")
   
    #IFS=$'\n' _vsout=($(printf '%s\n' "${existing[@]}" "${vs[@]}"|sort|uniq -u))
    mapfile -t -d $'\n' '_vsout' \
        < <(printf '%s\n' "${vsprevious[@]}" "${vsprevious[@]}" "${_vs[@]}"|sort|uniq -u)
 
    #declare -p '_vs' 1>&2
    #declare -p 'vsprevious' 1>&2
    #declare -p '_vsout' 1>&2

    #[ ${#_vsout[@]} -gt 0 ] && printf '%s\0' "${_vsout[@]}"
    if [ ! -z "$2" ];then
        mapfile -t -d $'\0' "$2" \
            < <([ "${#_vsout[@]}" -gt 0 ] && printf '%s\0' "${_vsout[@]}")
    fi
}

_directoryupdate(){
    :
    if [ ! -d "$1" ];then _errorf 'not found: %s' "$1";return 1;fi
    declare -a vs;_directorydelta "$1" 'vs'
    #declare -p 'vs'
    _infof 'found %d file(s) to be included in %s' "${#vs[@]}" "$1/$vfout"
    [ "${#vs[@]}" -gt 0 ]||return 0
    pushd "$1" 2>&1 >/dev/null  \
        && printf '%s\0' "${vs[@]}" \
            |xargs -0 -I'{}' md5sum {} |tee -a "$vfout" \
        && popd >/dev/null
}
_check(){
    local f d;f="$1"
    if [ -d "$1" ];then d="$1";f="$1/$vfout";fi
    if [ -f "$1" ];then d="$(dirname "$1")";fi
    if [ ! -f "$f" ];then _errorf 'not found: %s' "$f";return 1;fi
    pushd "$d" 2>&1 >/dev/null \
        && md5sum -c "$(basename "$f")" \
        && popd >/dev/null
}


if [ -d "$1" ];then
    set -- '--directory' "${@:1}" 
elif [ -f "$1" ];then
    set -- '--check' "${@:1}"
fi
case $1 in
    --directory)shift;_directoryupdate "$@";;
    --check)shift;_check "$@";;
    *)_usage;;
esac










