@echo off

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

title %title1%

call "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat"
msbuild  "%develop%\Source\vc32\orgmain\OriginAll.sln" /p:Configuration=%2 /p:Platform=%1 /m

pause
