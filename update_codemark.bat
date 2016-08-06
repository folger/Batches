@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

pushd %develop%

set newcodemarking=NewCodeMarking.txt
set codemarking=CodeMarking.txt

for /f "tokens=1-2" %%x in ("%date%") do (
	set b=%%x
	set c=!b:/=!
	if not !c!==!b! set curdate=%%x
)

for /f "delims=" %%i in ('git log --oneline -500') do (
	set b=%%i
	set c=!b:Ir9=!
	if not !c!==!b! (
		for %%j in (!b!) do set build=%%j
		goto :update
	)
)

:update

for /f "tokens=*" %%x in (%codemarking%) do (
	for /f "tokens=1-7" %%a in ("%%x") do (
		set handled=0
		if not [%%d]==[] (
			set b=%%d
			set c=!b:Ir=!
			if not !b!==!c! (
				echo %%a %%b %%c %build%>>%newcodemarking%
				set handled=1
			)
		)
		if !handled!==0 if not [%%b]==[] (
			set b=%%b
			set c=!b:/=!
			if not !b!==!c! (
				echo %%a %curdate% %%c %%d %%e %%f %build%>>%newcodemarking%
				set handled=1
			)
		)
		if !handled!==0 echo %%x>>%newcodemarking%
	)
)

del /q %codemarking%
rename %newcodemarking% %codemarking%

popd
