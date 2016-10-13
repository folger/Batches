@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Delete old support files ...

set src=\\fs1\dev\SupportFiles

set last=
for /f "delims=" %%i in ('dir "%src%" /b /ad-h /t:c /od') do (
	if not [!last!]==[] (
		echo Deleting !last!...
		rd /s /q !src!\!last!
	)
	set b=%%i
	set c=!b:Ir=!
	if not !c!==!b! (
		set latest=!b!
		set last=!b!
	) else (
		set last=
	)
)
echo Done~~~
pause
