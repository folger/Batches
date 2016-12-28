@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Check Git Repos

:check
choice /c SPQ /m "Show Status(S), Pull(P) or Quit(Q)"
set opt=%errorlevel%
if %opt%==3 exit /b

cls

set repos="%home%\vimfiles"^
		Batches^
		folstools^
		Python^
		pk10^
		djangobook^
		JIRA^
		folsnet^
		RCLocalize

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
	if !opt!==1 git status --short --branch
	if !opt!==2 git pull
	popd
)
echo %marker% Done %marker%
goto :check
