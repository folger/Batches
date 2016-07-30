@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

title Make Source Tags

pushd %develop%\.git

echo Start Making tags ...
D:\clang_lib\ctags --excmd=number --extra=+q -R ..\Origin\OriginC ..\Source
echo End Making tags ...

popd
