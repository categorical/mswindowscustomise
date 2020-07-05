
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



's.RegWrite "HKEY_CLASSES_ROOT\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder\Attributes","0xb094010c"
s.RegWrite "HKEY_CLASSES_ROOT\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder\Attributes",&Ha9400100&,"REG_DWORD"
's.RegWrite "HKEY_CLASSES_ROOT\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder\Attributes","0xb080010d"
'Restores defaults
's.RegWrite "HKEY_CLASSES_ROOT\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder\Attributes","0xb094010c"
's.RegWrite "HKEY_CLASSES_ROOT\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder\Attributes","0xa0900100"
's.RegWrite "HKEY_CLASSES_ROOT\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder\Attributes","0xb080010d"




'Creates an empty key "bar".
's.RegWrite "HKCU\foo\bar\qux","qux"
'WScript.Echo s.RegRead("HKCU\foo\bar\qux")
's.RegDelete "HKCU\foo\bar\qux"
's.RegDelete "HKCU\foo\bar\"
's.RegDelete "HKCU\foo\"


