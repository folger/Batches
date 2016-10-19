@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Delete old support files ...

set src=\\fs1\dev\SupportFiles

set last=
for /f "delims=" %%i in ('dir "%src%" /b /ad-h /t:c /od ^| find "Ir"') do (
	if not [!last!]==[] (
		echo Deleting !last!...
		rd /s /q !src!\!last!
	)
	set latest=%%i
	set last=%%i
)
echo Done~~~
pause
