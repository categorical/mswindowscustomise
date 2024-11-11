#!/Bin/Bash
set -eu
thisdir="$(cd "$(dirname "$0")" && pwd)"
rremove='hklm\software\classes\installer\products'
show(){ reg query "$rremove\\$1"|sed 's/\0d$//';}
list(){
declare -a arr
mapfile -t arr< <(reg query "$rremove"|sed \
    -e 's/\x0d$//' -e '/^$/d')
local u n v;for u in "${arr[@]}";do
n="${u##*\\}"
v="$(reg query "$u"\
    |sed 's/\x0d$//' \
    |sed 's/^\s*productname\s\+[A-Z_]*\s\+//i;t d;d;:d')"
printf '%-40s %s\n' "$n" "$v"
done
}
search(){ list|grep --color -i "$1";}
main(){ usage(){ cat<<1
$0 -list
$0 -show STR
$0 -search V
EPILOGUE
microsoft panics when inst new because it lost old
find old using this script and kill it
1
exit $1;}
[ $# -gt 0 ]||usage 1;while [ $# -gt 0 ];do case $1 in
-l|-list)   list;;
-i|-show)   shift;show "$1";;
-s|-search) shift;search "$1";;
-h)usage 0;;*)usage 1
esac;shift;done
};main "$@"
