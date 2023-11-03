
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
s.RegWrite "HKCU\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell\ExecutionPolicy","RemoteSigned"

s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoStartMenuMorePrograms",1,"REG_DWORD"

's.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoTrayItemsDisplay",1,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoTrayItemsDisplay",0,"REG_DWORD"
s.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSecondsInSystemClock",1,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\hideclock",0,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\hidescavolume",0,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\hidescapower",0,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\hidescanetwork",0,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\usedefaulttile",1,"REG_DWORD"

'enables msrdp to connect with en empty password
s.RegWrite "HKLM\System\CurrentControlSet\Control\Lsa\limitblankpassworduse",0,"REG_DWORD"

's.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\hidescahealth",1,"REG_DWORD"
'On Error Resume Next
's.RegDelete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\hidescahealth"
'On Error GoTo 0

' disables driver update?
's.RegWrite "HKLM\software\microsoft\windows\currentversion\driversearching\searchorderconfig",0,"REG_DWORD"
's.RegWrite "HKLM\software\microsoft\windows\currentversion\device metadata\preventdevicemetadatafromnetwork",1,"REG_DWORD"


s.RegWrite "HKLM\software\policies\microsoft\windows\explorer\disablenotificationcenter",1,"REG_DWORD"

On Error Resume Next
s.RegDelete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\securityhealth"
On Error GoTo 0
's.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\securityhealth","%windir%\system32\securityhealthsystray.exe","REG_EXPAND_SZ"

'BSOD when set to 0, i.e. S3 enabled
's.RegWrite "HKLM\System\CurrentControlSet\Control\Power\csenabled",0,"REG_DWORD"
's.RegWrite "HKLM\System\CurrentControlSet\Control\Power\csenabled",1,"REG_DWORD"

'disables hibernate, therefore, fast startup
s.RegWrite "HKLM\System\CurrentControlSet\Control\Power\hibernateenabled",0,"REG_DWORD"



On Error Resume Next
s.RegDelete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\rtkauduservice"
On Error GoTo 0

On Error Resume Next
s.RegDelete "HKLM\software\microsoft\windows\currentversion\explorer\startupapproved\run\rtkauduservice"
On Error GoTo 0

'On Error Resume Next
's.RegDelete "HKLM\software\microsoft\windows\currentversion\explorer\desktop\namespace\{645FF040-5081-101B-9F08-00AA002F954E}"
'On Error GoTo 0
's.RegWrite "HKLM\software\microsoft\windows\currentversion\explorer\desktop\namespace\{645FF040-5081-101B-9F08-00AA002F954E}\","recycle bin","REG_SZ"

s.RegWrite "HKEY_CLASSES_ROOT\batfile\shell\edit\command\","D:\opt\npp\notepad++.exe ""%1"""
s.RegWrite "HKEY_CLASSES_ROOT\VBSFile\Shell\Edit\Command\","D:\opt\npp\notepad++.exe ""%1"""
s.RegWrite "HKEY_CLASSES_ROOT\cmdfile\shell\edit\command\","D:\opt\npp\notepad++.exe ""%1"""
s.RegWrite "HKCR\Microsoft.PowerShellScript.1\Shell\Edit\Command\","D:\opt\npp\notepad++.exe ""%1"""
s.RegWrite "HKCR\blendfile\shell\open\command\","d:\opt\blender\blender.exe ""%1""","REG_SZ"

's.RegWrite "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir (x86)","d:\rubbish"
's.RegWrite "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir","d:\rubbish"
's.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir (x86)","C:\Program Files (x86)"
's.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ProgramFilesDir","C:\Program Files"






'Discards items from This PC.
'documents
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag\ThisPCPolicy","Hide"

'pictures
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag\ThisPCPolicy","Hide"

'videos
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag\ThisPCPolicy","Hide"

'downloads
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag\ThisPCPolicy","Hide"

'music
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag\ThisPCPolicy","Hide"

'desktop
s.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag\ThisPCPolicy","Hide"


'3d
On Error Resume Next
s.RegDelete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}\"
s.RegDelete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}\"
On Error GoTo 0


'onedrive
s.RegWrite "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree",0,"REG_DWORD"
s.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana",0,"REG_DWORD"


s.RegWrite "HKLM\System\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal",1,"REG_DWORD"
s.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Network\newnetworkwindowoff\","","REG_SZ"

Set fso=CreateObject("Scripting.FileSystemObject")

scriptdir=fso.GetParentFolderName(fso.GetFile(WScript.ScriptFullName))
fregini=scriptdir & "\permsregini":If fso.FileExists(fregini) Then
    s.Run "regini.exe " & chr(34) & fregini &chr(34),0,True
End If


'Removes from context menu after installing optical salon build tools.
On Error Resume Next
'Are there more?
s.RegDelete "HKCR\Directory\Background\shell\AnyCode\command\"
s.RegDelete "HKCR\Directory\Background\shell\AnyCode\"
s.RegDelete "HKCR\Directory\shell\AnyCode\command\"
s.RegDelete "HKCR\Directory\shell\AnyCode\"
On Error GoTo 0

'removes quick access
s.RegWrite "HKLM\software\microsoft\windows\currentversion\explorer\hubmode",1,"REG_DWORD"

'Prevents microsoft occasional pop up in case public smb share.
's.RegWrite "HKLM\software\policies\microsoft\windows\lanmanworkstation\allowinsecureguestauth",1,"REG_DWORD"

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
