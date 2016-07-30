@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

for /d %%X in (*) do (
	echo Pulling %%X
	pushd %%X
	git pull
	popd %%X
)
pause
