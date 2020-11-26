
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


s.RegWrite "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell\ExecutionPolicy","RemoteSigned"

s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoStartMenuMorePrograms",1,"REG_DWORD"

's.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoTrayItemsDisplay",1,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoTrayItemsDisplay",0,"REG_DWORD"
s.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSecondsInSystemClock",1,"REG_DWORD"


's.RegWrite "HKEY_CLASSES_ROOT\batfile\shell\edit\command\","D:\programs\npp\notepad++.exe %1"
's.RegWrite "HKEY_CLASSES_ROOT\VBSFile\Shell\Edit\Command\","D:\programs\npp\notepad++.exe %1"
's.RegWrite "HKEY_CLASSES_ROOT\cmdfile\shell\edit\command\","D:\programs\npp\notepad++.exe %1"


's.RegWrite "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir (x86)","d:\rubbish"
's.RegWrite "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir","d:\rubbish"



'Set fso=CreateObject("Scripting.FileSystemObject")

'scriptdir=fso.GetParentFolderName(fso.GetFile(WScript.ScriptFullName))
'fregini=scriptdir & "\permsregini":If fso.FileExists(fregini) Then
'    s.Run "regini.exe " & chr(34) & fregini &chr(34),0,True
'End If


'Shows/hides items at explorer naviation pane.
'libraries

's.RegWrite "HKCR\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder\Attributes",&Hb080010d&,"REG_DWORD"
's.RegWrite "HKCR\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder\Attributes",&Hb090010d&,"REG_DWORD"

'favourites
's.RegWrite "HKCR\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder\Attributes",&Ha0900100&,"REG_DWORD"
's.RegWrite "HKCR\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder\Attributes",&Ha9400100&,"REG_DWORD"

'homegroup
's.RegWrite "HKCR\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder\Attributes",&Hb084010c&,"REG_DWORD"
's.RegWrite "HKCR\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder\Attributes",&Hb094010c&,"REG_DWORD"





'Creates an empty key "bar".
's.RegWrite "HKCU\foo\bar\qux","qux"
'WScript.Echo s.RegRead("HKCU\foo\bar\qux")
's.RegDelete "HKCU\foo\bar\qux"
's.RegDelete "HKCU\foo\bar\"
's.RegDelete "HKCU\foo\"


