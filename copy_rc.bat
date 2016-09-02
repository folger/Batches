@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set entries="od.rc,Source\vc32\od" ^
			"oErrMsg.rc,Source\vc32\oErrMsg" ^
			"OLTmsg.rc,Source\vc32\OLTmsg" ^
			"OKern96.rc,Source\vc32\OKern96" ^
			"Origin50.rc,Source\vc32\Origin50" ^
			"OUser.rc,Source\vc32\OUser" ^
			"ODlg.rc,Source\DDK Tools\ODlg" ^
			"ODlg8.rc,Source\DDK Tools\ODlg8" ^
			"ODlgA.rc,Source\DDK Tools\ODlgA" ^
			"okUtil.rc,Source\MFC\okUtil\" ^
			"OIDE.rc,Source\MFC\oide\" ^
			"OCntrls.rc,Source\MFC\OCntrls\"

for %%a in (%entries%) do (
	for /f "tokens=1* delims=," %%b in (%%a) do (
		if exist %%b (
			echo %%b === %%c 
			copy %%b "%develop%\%%c" > nul
		)
	)
)
pause
