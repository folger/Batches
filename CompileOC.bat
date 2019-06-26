@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Compile OriginC

for /f "delims=" %%i in ('dir Origin*.exe /b /t:w /od') do set origin=%%i
:found_origin
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)

echo Found %origin% ...

set compileogs=%temp%\compile.ogs
set ocw=%temp%\dev.ocw
set output=%temp%\oc_error.txt

pushd OriginC
echo [Workspace]>%ocw%
set i=0
for /f "delims=" %%a in ('dir /s /b *.c*') do (
	set /a i+=1
	echo File!i!=%%a>>%ocw%
)
echo FileCount=%i%>>%ocw%
popd
echo Generated %ocw% ...

echo.>%compileogs%
echo win -n n;>>%compileogs%
echo type.redirection=2;>>%compileogs%
echo type.notes$=notes;>>%compileogs%
echo @RBA=1;>>%compileogs%
echo run.loadoc("%ocw%", 0);>>%compileogs%
echo save -n notes %output%;>>%compileogs%
echo ;doc -ss;exit;>>%compileogs%
echo Generated %compileogs% ...

echo Start %origin% to compile ...
%origin% -rs run.section(%compileogs%)

start notepad %output%

del %compileogs% 2>nul
del %ocw% 2>nul
