@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

pushd %parent%
for /f "delims=" %%i in ('dir Origin9*.exe /b /t:w /od') do set origin=%%i
:found_origin
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)

set version=%origin:Origin=%
set version=%version:.exe=%
set version=%version:_64=%

set platform=%me:GetDlls_=%

xcopy \\fs1\Dev\%version%_dlls\%platform% . /s /y
pause
