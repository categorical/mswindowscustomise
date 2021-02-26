#!/bin/bash


progdir='/cygdrive/d/programs'
f="$progdir/emacs/bin/emacs.exe"


"$f" "$@" 2>&1 >/dev/null &




