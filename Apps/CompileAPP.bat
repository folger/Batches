@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set apppath=%1
set apppath=%apppath:"=%
set apps=%localappdata%\Originlab\Apps

title Checking Apps ...

for /f "delims=" %%i in ('dir Origin*.exe /b /t:w /od') do set origin=%%i
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
for /r %apppath% %%a in (*.opx) do (
	set later=0
	set b=%%a
	set c=!b:Import Chem Data=!
	if not !b!==!c! set later=1
	if !later!==1 (
		if not [!installlater!]==[] set installlater=!installlater! 
		set installlater=!installlater!"!b!"
	) else (
		echo run -opxi !b!;>>%compileogs%
	)
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
for /d %%a in (%apps%\*) do (
	echo.>%compileogs%
	echo win -n n;>>%compileogs%
	echo type.redirection=2;>>%compileogs%
	echo type.notes$=notes;>>%compileogs%
	echo @RBA=1;>>%compileogs%
	echo run.section^(app_olocal, main, "%%~na"^);>>%compileogs%
	echo save -n notes %temp_result%;>>%compileogs%
	echo ;doc -ss;exit;>>%compileogs%
	echo Compiling %%~na ...
	%origin% -rs run.section^(%compileogs%^)
	type %temp_result% >> %app_results%
)

start notepad %app_results%

set app_results=%temp%\app_results.txt
echo.
for /f "delims=" %%a in ('findstr "\<Error\>" %app_results%') do echo %%a
rd /s /q %apps% 2>nul
echo Done~~~
pause
