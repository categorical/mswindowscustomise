#!/bin/bash



#thisdir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

_migrate(){
    f='/cygdrive/e/winfiles/hosts'
    [ -f "$f" ]||exit 1
    sudo bash -c "cat $f> /etc/hosts"
}

_edit(){
    sudo vi /etc/hosts
}


_usage(){
    cat <<-EOF
	SYNOPSIS:
	    $0 --edit
	    $0 --migrate
	EOF
}

case ${1:-'--edit'} in
    --migrate)_migrate;;
    --edit)_edit;;
    *)_usage;;
esac


