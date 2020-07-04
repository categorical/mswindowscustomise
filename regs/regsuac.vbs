
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

s.RegWrite "HKEY_CLASSES_ROOT\batfile\shell\edit\command\","D:\programs\npp-6.8.8\notepad++.exe %1"
s.RegWrite "HKEY_CLASSES_ROOT\VBSFile\Shell\Edit\Command\","D:\programs\npp-6.8.8\notepad++.exe %1"
s.RegWrite "HKEY_CLASSES_ROOT\cmdfile\shell\edit\command\","D:\programs\npp-6.8.8\notepad++.exe %1"


s.RegWrite "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir (x86)","d:\rubbish"
s.RegWrite "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir","d:\rubbish"

'Creates an empty key "bar".
's.RegWrite "HKCU\foo\bar\qux","qux"
'WScript.Echo s.RegRead("HKCU\foo\bar\qux")
's.RegDelete "HKCU\foo\bar\qux"
's.RegDelete "HKCU\foo\bar\"
's.RegDelete "HKCU\foo\"


