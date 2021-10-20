#!/bin/bash

_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}
dthis="$(cd "$(dirname "$0")"&&pwd)"

_copy(){
    local d1="$1"
    local d2="$2"
    local flog="${d2%/}.log"
    robocopy "$(cygpath -w "$d1")" "$(cygpath -w "$d2")" \
        /e /xj /r:0 /w:0 /log:"$(cygpath -w "$flog")"
    # the log file requires to reside in an existing directory

}


_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 source_dir dest_dir
	EPILOGUE
	    $0 ./foo/ bar       -   invariant output w.r.t. slashes
	    $0 'foo bar' qux    -   quote spaces
	    $0 foo bar/qux      -   invariant output w.r.t. existence of destination dir
	EOF
}
if [ $# -ne 2 ];then
    _usage;exit 1
fi

_copy "$@"



