@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set username=%1
set password=%2
set version=%3
set format=%4

for /f "delims=" %%i in ('dir "\\fs1\Builds\%version%\I" /b /ad-h /t:c /od ^| find "Ir"') do (
	set latest=%%i
)

if [%latest%]==[] (
	echo No Build Found
	pause
	exit /b
)

set latest=%latest:_H=%
for %%i in (1 2 3 4) do (
	set latest=!latest:.%%i=!
	set latest=!latest:_beta%%i=!
)

set modules= Origin%version%^
            ok9^
            okUtil9^
            Outl9^
            ou9^
            od9^
            O3DGL9^
            OK3DGL9^
            OCntrls9^
            ogrid9^
            OKXF9^
            omocavc9^
            OCompiler9^
            ocMath9^
            octree_Utils9^
            ocUtils9^
            gsodbc9^
            Lababf32^
            libapr^
            libsie^
            MOCABaseTypes9^
            nlsf9^
            oc3dx9^
            OCcontour9^
            ocim9^
            ocmath29^
            ocmathsp9^
            OCMmLink9^
            ocStatEx9^
            OCTree9^
            ocuv9^
            OCVImg^
            odbc9^
            odcfl9^
            oExtFile9^
            offt9^
            OFFTW9^
            ofgp9^
            ofio9^
            ohtmlhelp9^
            ohttp9^
            OIFileDlg9^
            oimg9^
            OImgLT9^
            OlbtEdit9^
            OLTmsg9^
            omail9^
            omat9^
            ONAG9^
            ONLSF9^
            OODBC9^
            OODR9^
            ooff60^
            OPack9^
            OPattern_Utils9^
            opencv_core^
            opencv_highgui^
            opencv_imgproc^
            opfm9^
            OPFMFuncs9^
            orespr9^
            OStat^
            Osts9^
            otext9^
            OTools^
            OTreeEditor9^
            oTreeGrid9^
            OUim9^
            OVideoReader9^
            OVideoWriter9^
            owxGrid9^
            wxbase28^
            wxmsw28_core^
            oErrMsg^
            nlsfWiz9^
            OImgProc^
            OImage^
            ORserve9^
			CrashRpt1402

set targetpath=\\fs1\dev\%format%s\%latest%

md %targetpath% 2>nul
pushd %targetpath%

for %%b in ($, _64) do (
	for %%a in (%modules%) do (
		set file=%%a%%b.!format!
		set file=!file:$=!
		if not exist !file! (
			set zipfile=!file!.zip
			title Downloading !file! into !targetpath!
			curl -u !username!:!password! -O ftp://98.118.55.13/Builds/!version!/MAP_and_PDB/!latest!/!zipfile!
			unzip !zipfile!
			del !zipfile!
		)
	)
)
explorer %targetpath%
echo Done~~~
pause
