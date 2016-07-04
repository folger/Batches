@echo off

for /f %%x in ("%date%") do set curdate=%%x

set holiday=0
if %curdate%==Sat set holiday=1
if %curdate%==Sun set holiday=1
if %holiday% == 1 shutdown /s /t 30

pushd %develop%
git pull
python "%folscode%\Python\BatchBuild\BuildCmd.py" OriginAll --platform=%1 --configuration=%2 --all-output
popd
