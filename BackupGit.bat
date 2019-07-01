@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0
set pscmd=powershell -ExecutionPolicy Bypass -Command

title Backup %cd%\.git
set zip=.\.git.zip
echo Compressing ...
%pscmd% Compress-Archive -CompressionLevel NoCompression -Path '.\.git\*' -DestinationPath '%zip%'
if exist %zip% (
	set des=\\fs1\shared\Folger
	echo Copying to !des! ...
	del /ah !des!\!zip! 2>nul
	copy !zip! !des!
	del !zip!
	echo Done~~~
) else (
	echo %zip% does not eixst !!!
)
pause
