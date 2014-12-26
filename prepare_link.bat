@echo off
set @folders=CustomTable ^
Filters ^
FitFunc ^
Themes

@echo on
for %%X in (%@folders%) do (
	rmdir %%X
	mklink /D %%X %develop%\Origin\%%X
)
