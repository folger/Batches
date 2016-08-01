@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set environment=HKCU\Environment

set entries="Develop,E:\Dev" ^
			"Diff,G:\Beyond Compare 4\BComp.exe" ^
			"Folscode,G:\folscode" ^
			"HOME,%USERPROFILE%"

for %%a in (%entries%) do (
	for /f "tokens=1* delims=," %%b in (%%a) do (
		echo %%b === %%c
		reg add %environment% /v %%b /t REG_SZ /d "%%c" /f > nul
	)
)

for /f "usebackq tokens=1,2*" %%a in (`reg query %environment% /v PATH`) do set currentpath=%%c

set paths="G:\Git\cmd" ^
		  "G:\Git\bin" ^
		  "C:\Python33\Scripts"
for %%a in (%paths%) do (
	set pp=%%a
	set currentpath=!pp:"=!;!currentpath!
)
echo PATH === %currentpath%
reg add %environment% /v PATH /t REG_SZ /d "%currentpath%" /f > nul
