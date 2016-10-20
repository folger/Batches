@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set path=J:\ffmpeg\bin;%path%

for %%a in (*.avi) do (
	if not exist %%~na.mp4 (
		title %%a
		ffmpeg -i %%a -y %%~na.mp4
	)
)
