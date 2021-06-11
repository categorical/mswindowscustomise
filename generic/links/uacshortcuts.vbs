
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
searchable(progdir & "deluge\deluge.exe")
searchable(progdir & "npp\notepad++.exe")
searchable(progdir & "emacs\bin\runemacs.exe")
searchable(progdir & "mozillafirefox\firefox.exe")
searchable(progdir & "regfromapp\regfromapp.exe")
searchable(progdir & "sharpkeys\sharpkeys.exe")
searchable(progdir & "wireshark\wireshark.exe")
searchable(progdir & "winspy\winspy.exe")
searchable(progdir & "moninfo\moninfo.exe")
searchable(progdir & "procmon\procmon64.exe")
searchable(progdir & "resourcehacker\resourcehacker.exe")
searchable(progdir & "imageglass\imageglass.exe")

searchablenargs progdir & "photoshop\photoshopportable.exe","photoshop",""
searchablenargs progdir & "bencode\bencode editor.exe","bencode",""
searchablenargs "d:\cygwin64\bin\mintty.exe","mintty","-"
searchablenargs progdir & "intellij\bin\idea64.exe","intellij",""
searchablenargs progdir & "vscode\code.exe","vscode",""
searchablenargs "C:\Program Files\Google\Chrome\Application\chrome.exe", _
    "chrome","--proxy-server="&chr(34)&s.ExpandEnvironmentStrings("%fooproxy%")&chr(34)
'searchablenargs progdir & "opera\launcher.exe","operanoupdate","--disable-update"












