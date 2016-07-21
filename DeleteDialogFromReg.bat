@echo off

reg delete "HKCU\SOFTWARE\Originlab\Origin %1\International\Dialogs" /f
