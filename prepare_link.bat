@echo off
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
pushd %~dp0
for %%X in (%@folders%) do (
	rmdir /s /q %%X
	mklink /D %%X %develop%\Origin\%%X
)
popd
