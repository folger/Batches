@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set branch=master
for /f %%a in ('git merge-base %branch% origin/%branch%') do set commonbase=%%a
echo Reset %branch% to %commonbase%
git reset --hard %commonbase%
pause
