

@echo off


set "item=Microsoft\Windows\LanguageComponentsInstaller\Installation"


schtasks /delete /tn "%item%" /f
schtasks /query /tn "%item%"

