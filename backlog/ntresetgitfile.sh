#!/bin/sh
set -eu
trap 'echo "exit $?">&2' EXIT
die(){ printf '\033[31me: \033[0m%s\n' "$1">&2;exit 1;}
proc(){ local "v=$1";[ -d "$v" ]&&cd "$v"\
&&git rev-parse --verify HEAD>/dev/null||die "$(set|grep ^v=)"
git status
git config core.filemode false
git ls-files -s|grep ^12000|awk '{print $4}'|xargs -r git checkout
}
main(){ usage(){ echo "$0 -proc DIR";exit $1;}
[ $# -gt 0 ]||usage 1;while [ $# -gt 0 ];do case $1 in
-proc)shift;proc "$1";;-h)usage 0;;*)usage 1;esac;shift;done;};main "$@"
