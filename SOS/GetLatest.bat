@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set user=folger
set password=""
set sos="%ProgramFiles(x86)%\SourceOffSite\soscmd.exe"
set log="%temp%\soslog.txt"
set sosdir=sosdir.txt
set marker=*********************

del %log% /q /f 2>nul

call :tee %marker%Getting From SOS%marker%
call :tee Start Time [%date%%time%]

for /f "tokens=*" %%x in (%sosdir%) do (
	for /f "tokens=1-3 delims=," %%a in ("%%x") do (
		set project=%%a
		set project=!project:ORGVER=%1!
		set workdir=%%b
		set workdir1=!workdir::=!
		if !workdir!==!workdir1! set workdir=!develop!\%%b
		set options=%%c
	)
	call :tee !project! === !workdir! [!options!]
	!sos! -command GetProject -server 98.118.55.12:8080 -name !user! -password !password! -alias vss ^
	-project "!project!" -workdir "!workdir!" -verbose !options! >> !log!
)

set xfunc=!develop!\Origin\X-Functions
xcopy /e /y %xfunc% !develop!\Origin\UFF\X-Functions\ > nul
rmdir /s /q %xfunc% > nul

call :tee End Time [%date%%time%]
call :tee %marker%Done !!!%marker%
start notepad %log%
pause
exit /b 0

::function to write to a log file and write to stdout
:tee
echo %*>> %log%
echo %*
exit /b 0
