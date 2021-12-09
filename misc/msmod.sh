#!/bin/bash





_usage(){
    cat<<-EOF
	SYNOPSYS
	    $0 FILE
	    $0 DIRECTORY

	EOF
}

_filemod(){
    local f="$1"
    case "$f" in
        *.exe);&
        *.cmd);&
        *.bat);&
        *.sh)chmod 775 "$f";;
        *)chmod 664 "$f";;
    esac
}


_msmod(){
    local d="$1";d="$(cygpath -u "$d")"
    if [ -f "$d" ];then
        sudo chown `whoami` "$d"
        _filemod "$d"

    elif [ -d "$d" ];then
        
        sudo takeown /f "$(cygpath -w "$d")" /r /d y
        sudo chmod -R 775 "$d"
        #chmod -R 775 "$d"
        fs=()
        # switch r to escape backslashes in a path might not be enough to have a "correct" path
        # cygpath -u and cygpath -w of the same file can disagree in the file's permissions
        while IFS= read -r -d $'\0';do
            fs+=("$REPLY")
        done< <(find "$d" -type f -print0)
        for f in "${fs[@]}";do
            _filemod "$f"
        done
    fi
}


if [ -z "$1" ]||[ ! -e "$1" ];then
    _usage
    exit 1
fi

_msmod "$1"



