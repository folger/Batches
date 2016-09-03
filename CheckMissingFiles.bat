@echo off
setlocal enableextensions enabledelayedexpansion
set me=%~n0
set parent=%~dp0

title Check missing files from vcxproj

for /f "delims=" %%a in ('dir /s /b *.vcxproj') do (
	set filedump=0
	pushd %%~dpa
	for /f "usebackq tokens=*" %%x in ("%%~nxa") do (
		set line=%%x
		set line1=!line:^<ClInclude Include=!
		if !line!==!line1! (
			set line1=!line:^<ClCompile Include=!
		)
		if not !line!==!line1! (
			set line2=!line1:^" /^>=!
			if not !line1!==!line2! (
				set line3=!line2:~2!
				if not exist !line3! (
					if !filedump!==0 (
						echo %%a
						set filedump=1
					)
					echo !line3!
				)
			)
		)
	)
	popd
)
pause
