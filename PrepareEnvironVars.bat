@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set environment=HKCU\Environment

reg add %environment% /v Develop /t REG_SZ /d "E:\Dev" /f
reg add %environment% /v Diff /t REG_SZ /d "G:\Beyond Compare 4\BComp.exe" /f
reg add %environment% /v Folscode /t REG_SZ /d "G:\folscode" /f
reg add %environment% /v HOME /t REG_SZ /d "%USERPROFILE%" /f
