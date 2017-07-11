@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

for /f "delims=" %%a in ('powershell -executionpolicy bypass -File ".\GetOrgModules.ps1" "." 1') do (
	echo Delete %%a ...
	del %%a 2>nul
)
pause
