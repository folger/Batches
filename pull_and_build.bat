@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set dev=%1
set platform=%2
set configuration=%3

title (%dev%) Pull Origin from Git and Build

pushd %dev%

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

title Removing Out folder ...
rd /s /q Out

popd

REM call maketags.bat


call "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat"
title (clucene.sln) Platform=%platform% Configuration=%configuration:Unicode=%
msbuild  "%dev%\Source\Module\OrgCLucene\clucene.sln" /p:Configuration=%configuration:Unicode=% /p:Platform=%platform% /m
title (OriginAll.sln) Platform=%platform% Configuration=%configuration%
msbuild  "%dev%\Source\vc32\orgmain\OriginAll.sln" /p:Configuration=%configuration% /p:Platform=%platform% /m
