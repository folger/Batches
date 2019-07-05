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
git submodule update --init
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

REM set vcpath= %VS110COMNTOOLS%..\..\VC
set vcpath=C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build
set sln_suffix=
call "%vcpath%\vcvarsall.bat" x86_amd64
title (clucene%sln_suffix%.sln) Platform=%platform% Configuration=%configuration%
msbuild  "%dev%\Source\Module\OrgCLucene\clucene%sln_suffix%.sln" /p:Configuration=%configuration% /p:Platform=%platform% /m
title (OriginAll%sln_suffix%.sln) Platform=%platform% Configuration=%configuration%
msbuild  "%dev%\Source\OriginAll%sln_suffix%.sln" /p:Configuration=%configuration% /p:Platform=%platform% /m
