#!/bin/bash



_e(){
    printf %s "$1"|sed 's/[\]/\\&/g'
}

#bash -c "$(_e "$*")"
#bash -c "$*"

bash -c "$@"


# cygstart does not respect number of args given to it,
# but it does parse args by spaces and quotes.
# Which means giving it one arg "echo 123": it treat that as two args.

