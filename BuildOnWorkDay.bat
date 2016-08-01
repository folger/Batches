@echo off
setlocal enableextensions
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

shutdown /s
