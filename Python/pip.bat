@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

echo Installing pip ...
python get-pip.py

set packages=bs4^
			"Django==1.8"^
			jira^
			pep8^
			PyExecJS^
			PyInstaller

for %%a in (%packages%) do (
	set package=%%a
	echo Installing !package:"=! ...
	pip.exe install %%a
)
