

Set s=WScript.CreateObject("WScript.Shell")
Set fso=CreateObject("Scripting.FileSystemObject")



progdir="D:\programs\"


Function withargs(i,args)
    If fso.FileExists(i) Then
        Set l=s.CreateShortcut(fso.BuildPath(fso.GetParentFolderName(i),fso.GetBaseName(i) &".lnk"))
        l.TargetPath=i
        l.Arguments=args
        l.Save
    End If
End Function

withargs progdir & "opera\launcher.exe", "--disable-update"

