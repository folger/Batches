@echo off

REM for /f %%x in ("%date%") do set curdate=%%x

REM set holiday=0
REM if %curdate%==Sat set holiday=1
REM if %curdate%==Sun set holiday=1
REM if %holiday% == 1 shutdown /s /t 30

pushd %develop%

git pull

pushd .git
call maketags.bat
popd

python "%folscode%\Python\BatchBuild\BuildCmd.py" OriginAll --platform=%1 --configuration=%2 --all-output

popd
