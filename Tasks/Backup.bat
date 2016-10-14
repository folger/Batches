@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

set mytasks="Check CR Cracked"^
			CopyBuild^
			DeleteOldSupportFiles^
			GetPDBs^
			GetSupport^
			SOSGetLatest^
			StartupBuild

for %%a in (%mytasks%) do (
	echo Backup %%a
	schtasks /query /tn %%a /XML > %%a.xml
)
