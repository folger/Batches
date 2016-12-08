@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set devorigin=

pushd %develop%\Origin

call fs1_GetSupport.bat NoPause

set xfs=X-Functions
xcopy %xfs%\*.oxf UFF\%xfs% /s /y /i
rmdir %xfs% /s /q

pushd %parent%
call %folscode%\Batches\copy_support.bat