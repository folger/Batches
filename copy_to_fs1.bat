@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

REM set path=%ProgramFiles%\7-Zip;%path%
set src=%1
set des=\\fs1\Builds\%2\I\
set zipdes=\\fs1\eSATADisk1\Builds\Zip Builds\%2
set build_files=%temp%\build_files.txt

title Copy build from %src% to %des%

for /f "delims=" %%i in ('dir "%src%\?r%2Sr*" /b /ad-h /t:c /od') do set a=%%i

if [%a%]==[] (
	echo No build found !!!
) else (
	if exist %des%%a% (
		echo %a% exists on %des% !!!
	) else (
		echo Copying %a% to %des%
		xcopy "%src%%a%" "%des%%a%" /s /i /y > nul
	)
	if exist "%zipdes%\%a%.zip" (
		echo %a%.zip exists on %zipdes% !!!
	) else (
		echo Zipping %a% to %zipdes%
		REM if exist %build_files% del %build_files%
		REM for %%i in (%src%%a%\*) do echo %%i >> %build_files%
		REM 7z a -tzip "%zipdes%\%a%.zip" @%build_files% > nul
		REM del %build_files%
		powershell -executionpolicy bypass -File ps1\Zip-Files.ps1 "%src:"=%%a%" "%zipdes%"
	)
)
pause
