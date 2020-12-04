




_begin(){
    :
    sudo reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion' /v 'ProgramFilesDir' /d 'd:\rubbish' /f
    sudo reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion' /v 'ProgramFilesDir (x86)' /d 'd:\rubbish' /f
}


_end(){
    :
sudo reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion' \
    /v 'ProgramFilesDir' /d 'C:\Program Files' /f
sudo reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion' \
    /v 'ProgramFilesDir (x86)' /d 'C:\Program Files (x86)' /f
}


_query(){
    reg query 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion'|grep 'ProgramFilesDir'
}


_usage(){
    cat<<-EOF
	SYNOPSIS:
	    $0 --begin
	    $0 --end
	    $0 --query
	EOF
}


case $1 in
    --begin)_begin;;
    --end)_end;;
    --query)_query;;
    *)_usage;;
esac




