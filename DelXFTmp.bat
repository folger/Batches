@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set exts=xfd _XF

:loop

pushd %1
for %%a in (%exts%) do (
	del *.%%a
)
popd

shift
if not "%1"=="" goto loop

pause
