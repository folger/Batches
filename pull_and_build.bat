@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set title1=Pull Origin from Git and Build
title %title1%

pushd %develop%

echo Pulling from git ...
git pull --rebase

if %errorlevel%==1 (
	echo Error when git pull, quit~
	pause
	exit /b
)

popd

call maketags.bat

title Platform=%1 Configuration=%2

call "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat"
msbuild  "%develop%\Source\vc32\orgmain\OriginAll.sln" /p:Configuration=%2 /p:Platform=%1 /m

pause
