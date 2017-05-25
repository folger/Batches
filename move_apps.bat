@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set repos="Data Slicer"^
		"DOE"^
		"Global Peak Fit"^
		"Peak Deconvolution"^
		"Paired Comparison Plot"^
		"OPJ Searcher"^
		"Object Identification"

for %%a in (%repos%) do (
	set repo=%%a
	set repo=!repo:"=!
	git mv "2017/!repo!/" "!repo!"
)
