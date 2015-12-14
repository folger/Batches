@echo off
set @folders=CustomTable ^
Filters ^
FitFunc ^
OriginC ^
Samples ^
Themes

@echo on
pushd H:\F_C_VC32
for %%X in (%@folders%) do (
	rmdir %%X
	mklink /D %%X %develop%\Origin\%%X
)
popd
