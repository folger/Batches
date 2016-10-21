@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set path=J:\ffmpeg\bin;%path%

for %%a in (*.avi) do (
	set des=%%~na.mp4
	if not exist !des! (
		title %%a
		ffmpeg -i %%a -y !des!
	)
)
