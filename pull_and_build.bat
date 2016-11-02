@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set platform=%1
set configuration=%2

title Pull Origin from Git and Build

pushd %develop%

echo Pulling from git ...



for /f %%a in ('git status --short') do set gitstatus=%%a
if not [%gitstatus%]==[] (
	echo Repo has unstaged changes, will be stashed
	git stash
)
git gc
:startpull
git pull --rebase
set waitsec=60
if not %errorlevel%==0 (
	echo Pull fail, wait %waitsec% to retry
	timeout %waitsec%
	goto :startpull
)

if %platform%==Win32 (
	for %%a in (ok oks) do rd /s /q Out\Temp\buildtmp32\%%a
)

popd

call maketags.bat

title Platform=%platform% Configuration=%configuration%

call "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat"
msbuild  "%develop%\Source\vc32\orgmain\OriginAll.sln" /p:Configuration=%configuration% /p:Platform=%platform% /m
