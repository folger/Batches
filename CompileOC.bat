@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Compile OriginC

set compileogs=compile.ogs
set ocw=dev.ocw

echo.>%ocw%
for /f "tokens=*" %%a in (%develop%\Origin\dev80.ocw) do (
	set b=%%a
	echo !b:D:\C94\Origin\=%parent%!>>dev.ocw
)

echo.>%compileogs%
echo @RBA=1;>>%compileogs%
echo string strDev = system.path.program$ + "dev.ocw";>>%compileogs%
echo run.loadoc(%%(strDev$), 0);>>%compileogs%
echo ty -b Done;>>%compileogs%

origin94_64 -rs run.section(compile)

del %compileogs% 2>nul
del %ocw% 2>nul
