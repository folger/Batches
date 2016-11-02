@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Compile OriginC

for /f "delims=" %%a in ('dir /b Origin*_64.exe 2^>nul') do (
	set origin=%%a
	goto :found_origin
)
:found_origin
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)

echo Found %origin% ...

set compileogs=%temp%\compile.ogs
set ocw=%temp%\dev.ocw

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
echo @RBA=1;>>%compileogs%
echo run.loadoc("%ocw%", 0);>>%compileogs%
echo ty -b Done;>>%compileogs%
echo Generated %compileogs% ...

echo Start %origin% to compile ...
%origin% -rs run.section(%compileogs%)

del %compileogs% 2>nul
del %ocw% 2>nul
