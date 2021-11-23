#!/Bin/Bash




dthis="$(cd "$(dirname "$0")" && pwd)"
dstaging="$dthis/foostaging"
finstaller='/cygdrive/d/downloads/VirtualBox-6.1.28-147628-Win.exe'




_install(){
    [ -d "$dstaging" ]&&(set -x;rm -rf "$dstaging")
    "$finstaller" \
        -extract \
        -path "$(cygpath -w "$dstaging")" \
        --silent
    local f="$(find "$dstaging" \
        -maxdepth 1 \
        -name *.msi \
        -type f \
        |head -n1)"
    msiexec /i "$(cygpath -w "$f")" \
        'installdir=d:\programs2' \
        /l*v "$(cygpath -w "$dstaging/installlog")" /qn \
        vbox_installdesktopshortcut=0 \
        vbox_installquicklaunchshortcut=0 \
        vbox_registerfileextensions=0 \
        vbox_installstartmenuentries=0 \
        vbox_start=0
}

_uninstallstrings(){

    :
    declare -a ks
    declare -A _vs
    mapfile -t -d $'\n' 'ks' \
        < <(reg query 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'|sed 's/\r$//')
    for k in "${ks[@]}";do
        local _guid="$(printf %s "$k" \
            |sed -n 's/^[^{]*\([-A-Z0-9{}]*\)$/\1/p')"
        [ -z "$_guid" ] && continue
        local v="$(reg query "$k" /v displayname \
            |sed -n 's/^\s*displayname\s\+[A-Z_]*\s\+//p')"
        _vs+=(["$_guid"]="$v")
    done
    
    for i in "${!_vs[@]}";do
        printf '%s %s\n' "$i" "${_vs[$i]}"
    done


}
# {73A88925-78D8-43C3-9F9F-24D4E5DFCD75}
_virtualboxuninstallstring(){
    :
    local q='oracle vm'
    local v="$(_uninstallstrings \
        |grep -i "$q"|head -n1|awk '{print $1}')"
    printf '%s' "$v"
}    

_remove(){
    #local uninstallstring="$(_virtualboxuninstallstring)"
    local uninstallstring='{73A88925-78D8-43C3-9F9F-24D4E5DFCD75}'
    msiexec /x "$uninstallstring" /qn \
        /l*v "$(cygpath -w "$dstaging/removelog")"
}

case $1 in
    --remove)_remove;;
    --install)_install;;
    *);;
esac







