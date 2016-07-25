@echo off

title Make Source Tags

pushd %develop%\.git

echo Start Making tags ...
D:\clang_lib\ctags --excmd=number --extra=+q -R ..\Origin\OriginC ..\Source
echo End Making tags ...

popd
