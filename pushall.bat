@echo off
for /d %%X in (*) do (
	echo Checking %%X
	pushd %%X
	git push
	popd %%X
)
pause
