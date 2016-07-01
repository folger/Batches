@echo off
setlocal enabledelayedexpansion

pushd %develop%

set newcodemarking=NewCodeMarking.txt
set codemarking=CodeMarking.txt

for /f "tokens=2" %%x in ("%date%") do set curdate=%%x

set src=\\fs1\Builds\94\I\
for /f "delims=" %%i in ('dir "%src%" /b /ad-h /t:c /od') do (
	set b=%%i
	set c=!b:Ir94Sr=!
	if not x!c!==x!b! set build=!b!
)

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
		if !handled!==0 (
			if not [%%b]==[] (
				set b=%%b
				set c=!b:/=!
				if not !b!==!c! (
					echo %%a %curdate% %%c %%d %%e %%f %build%>>%newcodemarking%
					set handled=1
				)
			)
		)
		if !handled!==0 echo %%x>>%newcodemarking%
	)
)

del /q %codemarking% 2>nul
rename %newcodemarking% %codemarking%
del /q %newcodemarking% 2>nul

popd
