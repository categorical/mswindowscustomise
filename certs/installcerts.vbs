If Not WScript.Arguments.Named.Exists("elevated") Then
    CreateObject("Shell.Application").ShellExecute _
        "wscript.exe", _
        Chr(34) & WScript.ScriptFullName & Chr(34) & " /elevated", _
        "", _
        "runas", _
        1
    WScript.Quit
End If

Set s=CreateObject("WScript.Shell")


certsdir="D:\files\"
Sub installcert(path)
    c="certutil.exe -addstore root " & chr(34) & path & chr(34):s.Run c,0,True
End Sub

installcert(certsdir & "charlesrootcertificate.pem")



