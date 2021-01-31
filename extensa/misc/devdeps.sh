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

_golangclean()(
    [ ! -d 'd:\godev' ]||set -x;rm -rf 'd:\godev'
)

_usage(){
    cat<<-EOF
	SYNOPSIS:
	    $0 --golang
	    $0 --golangclean
	EOF
}

case "${1}" in
    --golang)_golang;;
    --golangclean)_golangclean;;
    *)_usage;;
esac



