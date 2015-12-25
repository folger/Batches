@echo off
set @folders=CustomTable ^
Filters ^
FitFunc ^
OriginC ^
Samples ^
Themes ^
Localization ^
Hints ^
Templates

@echo on
pushd H:\F_C_VC32
for %%X in (%@folders%) do (
	rmdir /s /q %%X
	mklink /D %%X %develop%\Origin\%%X
)
popd
