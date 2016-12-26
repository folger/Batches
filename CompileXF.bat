@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Compile X-Functions

for /f "delims=" %%i in ('dir Origin*.exe /b /t:w /od') do set origin=%%i
:found_origin
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)

set version=%origin:~6,2%

echo Found %origin% ...

echo Start %origin% to compile ...
%origin% -rs list xc u;exit;

echo.
for /f "delims=" %%a in ('findstr "\<failed\>" C:\c%version%\xfocb.txt') do echo %%a
echo Done~~~

pause
