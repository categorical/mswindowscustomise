
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

s.RegWrite "HKEY_CLASSES_ROOT\batfile\shell\edit\command\","D:\Program Files\npp\notepad++.exe %1"
s.RegWrite "HKEY_CLASSES_ROOT\VBSFile\Shell\Edit\Command\","D:\Program Files\npp\notepad++.exe %1"
s.RegWrite "HKEY_CLASSES_ROOT\cmdfile\shell\edit\command\","D:\Program Files\npp\notepad++.exe %1"





Set fso=CreateObject("Scripting.FileSystemObject")

scriptdir=fso.GetParentFolderName(fso.GetFile(WScript.ScriptFullName))
fregini=scriptdir & "\permsregini":If fso.FileExists(fregini) Then
    s.Run "regini.exe " & chr(34) & fregini &chr(34),0,True
End If




'Creates an empty key "bar".
's.RegWrite "HKCU\foo\bar\qux","qux"
'WScript.Echo s.RegRead("HKCU\foo\bar\qux")
's.RegDelete "HKCU\foo\bar\qux"
's.RegDelete "HKCU\foo\bar\"
's.RegDelete "HKCU\foo\"


