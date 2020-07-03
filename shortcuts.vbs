


Set s=WScript.CreateObject("WScript.Shell")

progdir="D:\programs\"
bindir="D:\bin\"


Function _searchable(item)
    Set l=s.CreateShortcut(bindir & "ruby.lnk")

End Function
Set l=s.CreateShortcut(bindir & "ruby.lnk")
l.TargetPath=progdir & "ruby\bin\ruby.exe"
'l.Save
