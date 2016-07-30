@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

reg delete "HKCU\SOFTWARE\Originlab\Origin %1\International\Dialogs" /f
