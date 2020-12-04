
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



Function searchable(i)
    If fso.FileExists(i) Then
        Set l=s.CreateShortcut(searchdir & fso.GetBaseName(i) &".lnk")
        l.TargetPath=i
        l.Save
    End If
End Function

'searchable(progdir & "vlc\vlc.exe")

