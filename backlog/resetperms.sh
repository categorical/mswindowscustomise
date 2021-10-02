#!/bin/bash



_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
_error(){ printf "\033[31minfo: \033[0m%s\n" "$*";}


if [ ! -d "$1" ];then
    _errorf 'directory not found: %s' "$1"    
    cat <<-EOF
	SYNOPSIS:
	    "$0" DIRECTORY
	EOF
    exit 1
fi

user=$(whoami)
d=$1

chown -R "$user" "$d"
chmod -R 755 "$d"
find "$d" -type f -not -name '*.sh' -print0 |xargs -0 -I{} chmod 644 {}













