@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

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

popd

call maketags.bat

title Platform=%1 Configuration=%2

call "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat"
msbuild  "%develop%\Source\vc32\orgmain\OriginAll.sln" /p:Configuration=%2 /p:Platform=%1 /m
