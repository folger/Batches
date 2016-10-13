@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Compile X-Functions

for /f "delims=" %%a in ('dir /b Origin*.exe 2^>nul') do (
	set origin=%%a
	goto :found_origin
)
:found_origin
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)

set version=%origin:~6,2%

echo Found %origin% ...

echo Start %origin% to compile ...
%origin% -rs list xc u;exit;

echo ==========================================
for /f "delims=" %%a in (C:\c%version%\xfocb.txt) do (
	set result=%%a
	set result1=!result:failed=!
	if not [!result!]==[!result1!] echo %%a
)
echo Done~~~

pause
