@echo off

set orgver=Origin 9.4D

choice /c EGJC /m "Language (%orgver%)"

if %errorlevel%==1 set lan=E
if %errorlevel%==2 set lan=G
if %errorlevel%==3 set lan=J
if %errorlevel%==4 set lan=C

reg add "HKCU\SOFTWARE\Originlab\%orgver%" /v Language /t REG_SZ /d %lan% /f
