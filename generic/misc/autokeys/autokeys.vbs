



Set fso=CreateObject("Scripting.FileSystemObject")
scriptdir=fso.GetParentFolderName(fso.GetFile(WScript.ScriptFullName))


Set s=WScript.CreateObject("WScript.Shell")


executable="D:\programs\autohotkey\autohotkeyu64.exe"
f=scriptdir&"\autokeys"

s.Run executable&chr(32)&f,0,False









