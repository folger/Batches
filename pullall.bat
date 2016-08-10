@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set repos="%home%\vimfiles"^
		Batches^
		folstools^
		Python^
		pk10

set marker=************************
for %%a in (%repos%) do (
	set b=%%a
	set c=!b::=!
	if !b!==!c! (
		set repo=!folscode!\%%a
	) else (
		set repo=%%a
	)
	echo !marker! !repo:"=! !marker!
	pushd !repo!
	git status --short
	git pull
	popd
)
echo %marker% Done %marker%
pause
