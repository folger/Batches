@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set apppath=%1
set apps=%localappdata%\Originlab\Apps

title Checking Apps ...

for /f "delims=" %%i in ('dir Origin9*.exe /b /t:w /od') do set origin=%%i
if [%origin%]==[] (
	echo Origin executable cannot be found^^!^^!^^!
	exit /b 1
)
echo Found %origin% ...

set version=%origin:~6,2%

set compileogs=%temp%\compile.ogs

echo.>%compileogs%
echo Installing Apps ...
rd /s /q %apps% 2>nul
set installlater=
set apps_count=0
for /r %apppath% %%a in (*.opx) do (
	set later=0
	set b=%%a
	set c=!b:337=!
	if not !b!==!c! set later=1
	if !later!==1 (
		if not [!installlater!]==[] set installlater=!installlater! 
		set installlater=!installlater!"!b!"
	) else (
		echo run -opxi !b!;>>%compileogs%
	)
	set /a apps_count=!apps_count!+1
)
if not [%installlater%]==[] (
	for %%a in (%installlater%) do (
		set b=%%a
		set c=!b:"=!
		echo run -opxi !c!;>>%compileogs%
	)
)
echo ;doc -ss;exit;>>%compileogs%
%origin% -rs run.section(%compileogs%)

rd /s /q %localappdata%\Originlab\%version%\TMP\OCTemp 2>nul

set app_results=%temp%\app_results.txt
set temp_result=%temp%\temp_result.txt
echo.>%app_results%
set current_app=1
for /d %%a in (%apps%\*) do (
	echo.>%compileogs%
	echo win -n n;>>%compileogs%
	echo type.redirection=2;>>%compileogs%
	echo type.notes$=notes;>>%compileogs%
	echo @RBA=1;>>%compileogs%
	echo run.loadoc^(%parent%utils.cpp, 16^);>>%compileogs%
	echo run.section^(app_olocal, main, "%%~na" $^(GetAppIDByName^("%%~na"^)^)^);>>%compileogs%
	echo save -n notes %temp_result%;>>%compileogs%
	echo ;doc -ss;exit;>>%compileogs%
	echo ^(!current_app!/!apps_count!^) Compiling %%~na ...
	set /a current_app=!current_app!+1
	%origin% -rs run.section^(%compileogs%^)
	type %temp_result% >> %app_results%
)

start notepad %app_results%

echo.
for /f "delims=" %%a in ('findstr "\<:Error\>" %app_results%') do echo %%a
REM rd /s /q %apps% 2>nul
echo Done~~~
pause
