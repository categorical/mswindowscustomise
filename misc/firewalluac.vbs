
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


n="sshd"
s.Run "netsh advfirewall firewall delete rule name="&chr(34)&n&chr(34),0,True
s.Run "netsh advfirewall firewall add rule name=" _
    &Chr(34)&n&chr(34)&" dir=in protocol=tcp localport=22 action=allow profile=private,public",0,True



