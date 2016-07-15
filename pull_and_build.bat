@echo off

REM for /f %%x in ("%date%") do set curdate=%%x

REM set holiday=0
REM if %curdate%==Sat set holiday=1
REM if %curdate%==Sun set holiday=1
REM if %holiday% == 1 shutdown /s /t 30

pushd %develop%

git pull --rebase

pushd .git
call maketags.bat
popd

call "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat"
msbuild  "Source\vc32\orgmain\OriginAll.sln" /p:Configuration=%2 /p:Platform=%1 /m

popd

pause
