#!/bin/bash


_golang(){
    local d="$GOPATH"
    local prefix='d:\godev'
    [ "$d" = 'd:\godev' ]||exit 1
    [ -d "$d" ]||mkdir "$d"

    go get 'golang.org/x/tools/gopls'
    go get 'github.com/uudashr/gopkgs/v2/cmd/gopkgs'
    go get 'github.com/ramya-rao-a/go-outline'
    go get 'github.com/go-delve/delve/cmd/dlv'
    go get 'golang.org/x/lint/golint'
}

_golangclear()(
    [ ! -d 'd:\godev' ]||set -x;rm -rf 'd:\godev'
)

_usage(){
    cat<<-EOF
	SYNOPSIS:
	    $0 --golang
	    $0 --golangclear
	EOF
}

case "${1}" in
    --golang)_golang;;
    --golangclear)_golangclear;;
    *)_usage;;
esac



