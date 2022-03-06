#!/bin/bash


_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}


_template(){
cat <<'EOD'
#!/bin/bash
set -euo pipefail
#_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
#_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
#_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
#_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
#dthis="$(dirname "$(readlink -f "$0")")"
dthis="$(cd "$(dirname "$0")"&&pwd)"
_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -h
	EOF
    exit $1
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    *)_usage 0;;
esac;shift;done

EOD
}

_touch(){
    [ ! -e "$1" ]||{ _errorf 'file exists: %s' "$1";return 1;}
    printf '%s' "$(_template)" > "$1" \
        && chmod u+x "$1"
}


_usage(){
    cat<<-EOF
	SYNOPSIS
	    $(basename $0) [FILE]
	EOF
}

if [ -z "$1" ];then _usage;else _touch "$1";fi














