@echo off
setlocal enabledelayedexpansion
set path=C:\Program Files\7-Zip;%path%
set src=%1
set des=\\fs1\Builds\94\I\
set zipdes=\\fs1\Released\ZipBuilds\94\
set build_files=build_files.txt
for /f "delims=" %%i in ('dir "%src%" /b /ad-h /t:c /od') do (
	set b=%%i
	set c=!b:Ir94Sr=!
	if not x!c!==x!b! set a=!b!
)
if exist %des%%a% (
	echo %a% exists on %des% !!!
) else (
	echo Copying %a% to %des%
	xcopy "%src%%a%" "%des%%a%" /s /i /y > nul
)
if exist %zipdes%%a%.zip (
	echo %a%.zip exists on %zipdes% !!!
) else (
	echo Zipping %a% to %zipdes%
	if exist %build_files% del %build_files%
	for %%i in (%src%%a%\*) do echo %%i >> %build_files%
	7z a -tzip "%zipdes%%a%.zip" @%build_files% > nul
	del %build_files%
)
pause
