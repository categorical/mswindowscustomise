#!/bin/bash


_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}


_template(){
cat <<'EOD'
#!/bin/bash
_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}
dthis="$(cd "$(dirname "$0")"&&pwd)"
_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -h
	EOF
}
case $1 in
    *)_usage;;
esac

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














