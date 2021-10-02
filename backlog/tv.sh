#!/bin/bash


item=teamviewer

_usage(){
    cat <<-EOF
	SYNOPSIS:
	    $0 --start
	    $0 --stop
	EOF

}

case $1 in
    --start)sudo sc start "$item";;
    --stop)sudo sc stop "$item";;
    *)_usage;;
esac




