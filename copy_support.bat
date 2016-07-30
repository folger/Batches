@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

for %%Y in (otp, otw, otm, ogs, ini, cnf, bmp, xml) do (
	for %%X in (%develop%\Origin\*.%%Y) do (copy %%X %%~nxX)
)
