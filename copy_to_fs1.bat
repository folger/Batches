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

for /f "delims=" %%i in ('dir "%src%\Ir%2Sr*" /b /ad-h /t:c /od') do set build=%%i

if [%build%]==[] (
	echo No build found !!!
) else (
	if exist %des%%build% (
		echo %build% exists on %des% !!!
	) else (
		echo Copying %build% to %des%
		xcopy "%src%%build%" "%des%%build%" /s /i /y > nul
	)
	if exist "%zipdes%\%build%.zip" (
		echo %build%.zip exists on %zipdes% !!!
	) else (
		echo Zipping %build% to %zipdes%
		REM if exist %build_files% del %build_files%
		REM for %%i in (%src%%build%\*) do echo %%i >> %build_files%
		REM 7z a -tzip "%zipdes%\%build%.zip" @%build_files% > nul
		REM del %build_files%
		powershell -ExecutionPolicy Bypass -Command Compress-Archive -Path '%src:"=%%build%\*.*' -DestinationPath '%zipdes%\%build%.zip'
	)
)
pause
