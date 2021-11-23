#!/Bin/Bash




dthis="$(cd "$(dirname "$0")" && pwd)"
reg_uninstall='HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
reg32_uninstall='HKLM\SOFTWARE\wow6432node\Microsoft\Windows\CurrentVersion\Uninstall'



_list(){

    :
    declare -a ks
    declare -A _vs
    mapfile -t -d $'\n' 'ks' \
        < <(reg query "$reg_uninstall"|sed 's/\r$//')
    for k in "${ks[@]}";do
        #local _guid="$(printf %s "$k" \
        #    |sed -n 's/^[^{]*\({[-A-Z0-9]*}\)$/\1/p')"
        local _guid="${k##*\\}"
        
        [ -z "$_guid" ] && continue
        local v="$(reg query "$k" \
            |sed -n 's/^\s*displayname\s\+[A-Z_]*\s\+//ip')"
        #local v="$(reg query "$k" \
        #    |sed -n 's/^\s*uninstallstring\s\+[A-Z_]*\s\+//ip')"
        [ -z "$v" ]&&continue
        _vs+=(["$_guid"]="$v")
    done
    
    for i in "${!_vs[@]}";do
        printf '%-40s %s\n' "$i" "${_vs[$i]}"
    done


}

_get(){
    :
    local q="$1"
    local v="$(_list \
        |grep -i "$q"|head -n1|awk '{print $1}')"
    printf '%s' "$v"
}    


_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --list
	    $0 --get q
	EPILOGUE
	    $0 --get 'oracle vm'
	EOF


}

case $1 in
    --*|-*);;
    *)if [ ! -z "$1" ];then set -- '--get' "$@";fi;;
esac

case $1 in
    --list)_list|sort;;
    --get)shift;_get "$@";;
    *)_usage;;
esac






