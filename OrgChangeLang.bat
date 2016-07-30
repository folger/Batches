@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set orgver=Origin %1

title Change %orgver% Languague

choice /c EGJC /m "Language (%orgver%)"

if %errorlevel%==1 set lan=E
if %errorlevel%==2 set lan=G
if %errorlevel%==3 set lan=J
if %errorlevel%==4 set lan=C

reg add "HKCU\SOFTWARE\Originlab\%orgver%" /v Language /t REG_SZ /d %lan% /f
