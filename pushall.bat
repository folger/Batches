@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

for /d %%X in (*) do (
	echo Pushing %%X
	pushd %%X
	git push
	popd %%X
)
pause
