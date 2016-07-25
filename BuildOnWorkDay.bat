@echo off

for /f %%x in ("%date%") do set curdate=%%x

set holiday=0
if %curdate%==Sat set holiday=1
if %curdate%==Sun set holiday=1
if %holiday% == 1 (
	shutdown /s /t 30
	exit /b
)

pushd %~dp0
call pull_and_build.bat %1 %2
popd

