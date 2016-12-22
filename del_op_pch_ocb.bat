@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

for /f "delims=" %%i in ('dir Origin*.exe /b /t:w /od') do set origin=%%i
:found_origin
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)

set version=%origin:~6,2%

title Deleting %version% compile temp files ...

del /S /F /Q *.op
del /S /F /Q *.ocb
del /S /F /Q *.pch
del /S /F /Q *.oph

cd /d %USERPROFILE%\AppData\Local\OriginLab\%version%\TMP
if %ERRORLEVEL% == 0 (
del /S /F /Q *.ocb
del /S /F /Q *.pch
del /S /F /Q *.oph
)
