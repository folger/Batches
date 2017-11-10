@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set username=%1
set password=%2
set version=%3
set format=%4
set exepath=%5

for /f "delims=" %%i in ('dir "\\fs1\Builds\%version%\I\Ir9*" /b /ad-h /t:w /od') do set latest=%%i

if [%latest%]==[] (
	echo No Build Found
	pause
	exit /b
)

set latest=%latest:_H=%
for %%i in (0 1 2 3 4) do (
	set latest=!latest:.%%i=!
	set latest=!latest:_beta%%i=!
)

set targetpath=\\fs1\dev\%format%s\%latest%

md %targetpath% 2>nul

pushd %targetpath%
for /f "delims=" %%a in ('powershell -executionpolicy bypass -File "%parent%GetOrgModules.ps1" "%exepath%"') do (
	set file=%%a.!format!
	set file=!file:$=!
	if not exist !file! (
		set zipfile=!file!.zip
		title Downloading !file! into !targetpath!
		curl -u !username!:!password! -O ftp://98.118.55.13/Builds/!version!/MAP_and_PDB/!latest!/!zipfile!
		unzip !zipfile!
		del !zipfile!
	)
)
popd
explorer %targetpath%
echo Done~~~
pause
