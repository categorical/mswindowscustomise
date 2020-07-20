

fa="$HOME/.bash_aliases"


_esed(){
    printf '%s' "$1"|sed 's/[.[\*^$/]/\\&/g'
}


_u(){
    local d='='
    local f=$1
    [ -f "$f" ]||exit 1
    local l=$2
    # Contains the delimiter.
    [ ! -z "$l" ] && [ -z "${l##*$d*}" ]||exit 1
    local k="${l%%$d*}";k=$(_esed "$k")
    l=$(_esed "$l");d=$(_esed "$d")
    
    sed -i "/^$k$d/{h;s/.*/$l/};\${x;/^$/{s//$l/;H};x}" "$f"
}

_alias(){
    _u "$fa" "alias $1"
}

_alias "grep='grep --color'"
_alias "ls='ls --color=auto'" 
_alias "m='mintty -'"







