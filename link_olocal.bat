@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

pushd %parent%
for %%a in (G J C) do (
	mklink oLocal%%a.txt %develop%\Origin\oLocal%%a.txt
)
