@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

for /f "delims=" %%a in ('git log --oneline --name-status -n %1') do (
	set line=%%a
	set line2=!line:A	=!
	if not [!line!]==[!line2!] (
		echo !line2!
	)
)

pause
