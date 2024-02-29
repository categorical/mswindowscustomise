#!/bin/bash
set -eu
onexit(){ printf 'exit: %d\n' $?>&2;};trap onexit EXIT
say(){ printf '\e[36mI: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;}
die(){ printf '\e[31mE: \e[0m%s\n' "$(printf "$1" "${@:2}")">&2;exit 1;}
thisdir=$(cd "$(dirname "$0")" && pwd)

c1='hklm\software\policies\microsoft\windows\personalization'
c2='hkcu\control panel\desktop'
rst='c:\windows\web\wallpaper\windows\img0.jpg'
setv(){
    in="${in-$rst}"
    [ -r "$in" ]||die "$(declare -p in)"
    in="$(cygpath -w "$(realpath "$in")")"
}
setlck(){
    sudo reg add "$c1" /f /d "$in" /t reg_sz /v lockscreenimage
}
setbg(){
# microsoft relies on this newline
powershell -c -< <(cat<<EOF|sed '$s/$/\x0a/'
\$i=@'
using System.Runtime.InteropServices;
public class i{
[DllImport("user32.dll")]
public static extern int SystemParametersInfoA(int i1,int i2,string i3,int i4);
}
'@
add-type \$i
\$r=[i]::systemparametersinfoa(20,0,'$in',3);
# c:\program files (x86)\windows kits\10\include\10.0.18362.0\um\winuser.h
# SPIF_UPDATEINIFILE    0x01
# SPIF_SENDCHANGE       0x02
# SPI_SETDESKWALLPAPER  0x14
EOF
)
#reg add "$c2" /f /d "$in" /t reg_sz /v wallpaper
#rundll32 'user32.dll,updateperusersystemparameters 1,true'
# $ strings 'c:\windows\system32\user32.dll'|grep -i updatep
}
get(){
    reg query "$c1" /v lockscreenimage
    reg query "$c2" /v wallpaper
}
_main(){ _usage(){ cat<<-EOF
	SYNOPSIS:
	    $0 -setbg|-setlck [-in IM]
	    $0 -get
	EXAMPLE
	    $0 -setbg -in 'c:\windows\web\screen\img103.png'
	EOF
    exit $1;}
    declare -a a;while [ $# -gt 0 ];do case $1 in
        -in)shift;in="$1";;
        *)a+=("$1")
    esac;shift;done;setv;set -- "${a[@]}"
    [ $# -gt 0 ]||_usage 1;while [ $# -gt 0 ];do case $1 in
        -setbg)setbg;;
        -setlck)setlck;;
        -get)get;;
        -h)_usage 0;;*)_usage 1
    esac;shift;done
};_main "$@"
