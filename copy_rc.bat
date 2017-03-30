@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set entries="od.rc,vc32\od" ^
			"oErrMsg.rc,vc32\oErrMsg" ^
			"OLTmsg.rc,vc32\OLTmsg" ^
			"OKern96.rc,vc32\OKern96" ^
			"Origin50.rc,vc32\Origin50" ^
			"OUser.rc,vc32\OUser" ^
			"ODlg.rc,DDK Tools\ODlg" ^
			"ODlg8.rc,DDK Tools\ODlg8" ^
			"ODlgA.rc,DDK Tools\ODlgA" ^
			"okUtil.rc,MFC\okUtil" ^
			"OIDE.rc,MFC\oide" ^
			"OCntrls.rc,MFC\OCntrls" ^
			"OTreeEditor.rc,MFC\OTreeEditor" ^
			"ohttp.rc,Module\ohttp" ^
			"Import Wizard.rc,DDK Tools\ImportWiz" ^
			"Tab_Test.rc,DDK Tools" ^
			"oimg.rc,Module\oimg" ^
			"nlsf_wizard.rc,DDK Tools\NLSFWiz"

for %%a in (%entries%) do (
	for /f "tokens=1* delims=," %%b in (%%a) do (
		if exist %%b (
			echo %%b === %%c 
			copy "%%b" "%develop%\Source\%%c" > nul
		)
	)
)
pause
