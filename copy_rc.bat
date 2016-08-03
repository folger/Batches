@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set entries="od.rc,Source\vc32\od" ^
			"oErrMsg.rc,Source\vc32\oErrMsg" ^
			"OKern96.rc,Source\vc32\OKern96" ^
			"Origin50.rc,Source\vc32\Origin50" ^
			"OUser.rc,Source\vc32\OUser" ^
			"ODlg.rc,Source\DDK Tools\ODlg" ^
			"ODlg8.rc,Source\DDK Tools\ODlg8" ^
			"okUtil.rc,Source\MFC\okUtil\okUtil.rc" ^
			"OIDE.rc,Source\MFC\oide\OIDE.rc"

for %%a in (%entries%) do (
	for /f "tokens=1* delims=," %%b in (%%a) do (
		if exist %%b (
			echo %%b === %%c 
			copy %%b "%develop%\%%c" > nul
		)
	)
)
pause
