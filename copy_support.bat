@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

title Copy support files for %cd%
for %%Y in (otp otw otm ogs ini cnf bmp xml ogo dot) do (
	for %%X in (%develop%\Origin\*.%%Y) do (
		echo %%~nxX copied
		copy %%X %%~nxX > nul
	)
)
pause
