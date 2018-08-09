@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set path=J:\ffmpeg\bin;%path%

for %%a in (*.mkv) do (
	set mp4file="MP4\%%~na.mp4"
	if not exist !mp4file! (
		title !mp4file!
		ffmpeg -i %%a -vcodec libx264 -crf 24 !mp4file!
	)
)
start .\MP4
