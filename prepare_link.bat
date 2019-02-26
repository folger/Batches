@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

pushd %parent%
for %%Y in (otp otw otm otpu otwu otmu ogs ini cnf bmp xml ogo dot flt) do (
	del *.%%Y
	for %%X in (%develop%\Origin\*.%%Y) do (
		set file=%%~nxX
		del !file! 2>nul
		mklink "!file!" "%%X"
	)
)

set @folders=CustomTable ^
Filters ^
FitFunc ^
OriginC ^
Samples ^
Themes ^
Localization ^
Hints ^
Templates ^
PlotPopup ^
Palettes ^
Patterns ^
Ohtml ^
X-Functions ^
LTF ^
JS

echo.
echo.

for %%X in (%@folders%) do (
	rmdir /s /q %%X 2>nul
	mklink /j "%%X" "%develop%\Origin\%%X"
)
pause
