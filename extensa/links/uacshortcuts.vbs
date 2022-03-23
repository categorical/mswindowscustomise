
If Not WScript.Arguments.Named.Exists("elevated") Then
    CreateObject("Shell.Application").ShellExecute _
        "wscript.exe", _
        Chr(34) & WScript.ScriptFullName & Chr(34) & " /elevated", _
        "", _
        "runas", _
        1
    WScript.Quit
End If



Set s=WScript.CreateObject("WScript.Shell")
Set fso=CreateObject("Scripting.FileSystemObject")



progdir="D:\programs\"
dopt="d:\opt\"
searchdir=s.SpecialFolders("AllUsersPrograms") & "\_search\"


Function link(f,d,n,args)
    If fso.FileExists(f) Then
        If Len(n)=0 Then n=fso.GetBaseName(f) End If
        Set l=s.CreateShortcut(fso.BuildPath(d,n &".lnk"))
        l.TargetPath=f
        l.Arguments=args
        l.Save
    End If
End Function
Function searchablenargs(i,n,args)
    If Not fso.FolderExists(searchdir) Then fso.CreateFolder(searchdir) End If
    Call link(i,searchdir,n,args)
End Function
Function searchable(i)
    Call searchablenargs(i,"","") 
End Function


'searchable(progdir & "vlc\vlc.exe")
searchable(dopt & "deluge\deluge.exe")
searchable(dopt & "npp\notepad++.exe")
searchable(dopt & "emacs\bin\runemacs.exe")
searchable(dopt & "mozillafirefox\firefox.exe")
searchable(dopt & "regfromapp\regfromapp.exe")
searchable(dopt & "sharpkeys\sharpkeys.exe")
searchable(progdir & "wireshark\wireshark.exe")
searchable(progdir & "moninfo\moninfo.exe")
searchable(dopt & "virtualbox\virtualbox.exe")
searchable(dopt & "console2\console.exe")
searchable(dopt & "winspy\winspy.exe")
searchable(dopt & "msiafterburner\msiafterburner.exe")
'searchable(dopt & "rtss\rtss.exe")

searchable(progdir & "darkstar\darkstar.exe")
'searchable(progdir & "redalert2\ra2.exe")
'searchable(progdir & "redalert2\ra2md.exe")
searchable(dopt & "charles\charles.exe")


'searchablenargs "d:\cygwin64\bin\mintty.exe","mintty","-"
'searchablenargs "d:\cygwin64\bin\mintty.exe","mintty","-o font="&chr(34)&"unifont"&chr(34)&" -"
searchablenargs "d:\cygwin64\bin\mintty.exe","mintty","-o font="&chr(34)&"dejavu sans mono"&chr(34)&" -"



searchablenargs dopt & "vscode\code.exe","vscode",""
searchablenargs progdir & "opera\launcher.exe","operanoupdate", _
    "--disable-update --proxy-server="&chr(34)&s.ExpandEnvironmentStrings("%msproxy%")&chr(34)

'searchablenargs "C:\Program Files\Google\Chrome\Application\chrome.exe", _
'    "chrome","--proxy-server="&chr(34)&s.ExpandEnvironmentStrings("%msproxy%")&chr(34)


searchablenargs dopt & "chrome\chrome.exe", _
    "chrome","--proxy-server="&chr(34)&s.ExpandEnvironmentStrings("%msproxy%")&chr(34)& _
    " "















