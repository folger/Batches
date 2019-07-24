@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

pushd %parent%
set file=log.txt
echo. > %file%
for /l %%a in (1,1,10) do (
  echo Generating %%ath dmp file >> %file%
  procdump64.exe origin.exe >> %file%
  ping 127.0.0.1 -n 2 > nul
)
popd
pause
