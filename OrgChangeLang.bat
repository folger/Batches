@echo off

choice /c EGJC /m "Language "

if %errorlevel%==1 set lan=E
if %errorlevel%==2 set lan=G
if %errorlevel%==3 set lan=J
if %errorlevel%==4 set lan=C

reg add "HKCU\SOFTWARE\Originlab\Origin 9.4D" /v Language /t REG_SZ /d %lan% /f
