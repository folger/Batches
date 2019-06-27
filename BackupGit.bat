@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0
set pscmd=powershell -ExecutionPolicy Bypass -Command

title Backup %cd%\.git
set zip=.\.giz.zip
echo Compressing ...
%pscmd% Compress-Archive -CompressionLevel NoCompression -Path '.\.git\*' -DestinationPath '%zip%'
set des=\\fs1\shared\Folger
echo Copying to %des% ...
copy %zip% %des%
del %zip%
echo Done~~~
pause
