@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

for /f %%x in ("%date%") do set curdate=%%x

set weekend=0
if %curdate%==Sat set weekend=1
if %curdate%==Sun set weekend=1
if %weekend%==0 (
	pushd %parent%
	call pull_and_build.bat %1 %2
	popd
)

set /a count=%3
if not [%3]==[] (
:showcount
	title Windows will shutdown in %count% seconds, Ctrl+C to cancel
	timeout /t 1 > nul
	set /a count=%count%-1
	if %count% gtr 0 goto :showcount
)

shutdown /s /f
