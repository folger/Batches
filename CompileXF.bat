@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0
set pscmd=powershell -ExecutionPolicy Bypass -Command


for /f "delims=" %%i in ('dir Origin*.exe /b /t:w /od') do set origin=%%i
:found_origin
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)

set GCI="&{Get-ChildItem 'Origin*.exe'|Sort-Object LastWriteTime -Descending}"
for /f "usebackq delims=" %%i in (`%pscmd% ^(%GCI%^)[0].VersionInfo.ProductVersion.Replace^('.'^, ''^)`) do set version=%%i
for /f "usebackq delims=" %%i in (`%pscmd% if ^(^(%GCI%^)[0].VersionInfo.FileDescription -match 'Origin \d+^([a-z]^)'^) {$matches[1]}`) do set version=%version%%%i
for /f "usebackq delims=" %%i in (`%pscmd% if ^(^(%GCI%^)[0].VersionInfo.IsDebug^) {'D'} else {''}`) do set version=%version%%%i

title Compile %version% X-Functions

echo Found %origin% ...

echo Start %origin% to compile ...
%origin% -rs list xc;exit;

echo.
for /f "delims=" %%a in ('findstr "\<failed\>" C:\c%version%\xfocb.txt') do echo %%a
echo Done~~~

pause
