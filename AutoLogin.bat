@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set Winlogon="HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

set entries="AutoAdminLogon,1" ^
			"DefaultUserName,u" ^
			"DefaultPassword,p"

for %%a in (%entries%) do (
	for /f "tokens=1* delims=," %%b in (%%a) do (
		echo %%b === %%c
		reg add %Winlogon% /v %%b /t REG_SZ /d "%%c" /f > nul
	)
)
pause
