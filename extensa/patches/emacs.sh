#!/bin/bash


progdir='/cygdrive/d/programs'
dopt='/cygdrive/d/opt'
f="$dopt/emacs/bin/emacs.exe"


"$f" "$@" 2>&1 >/dev/null &




