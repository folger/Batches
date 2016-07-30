@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set @folders=CustomTable ^
Filters ^
FitFunc ^
OriginC ^
Samples ^
Themes ^
Localization ^
Hints ^
Templates ^
Startup ^
"Origin Central"

@echo on
pushd %parent%
for %%X in (%@folders%) do (
	rmdir /s /q %%X
	mklink /D %%X %develop%\Origin\%%X
)
popd
