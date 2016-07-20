@echo off
for /d %%X in (*) do (
	echo Pulling %%X
	pushd %%X
	git pull
	popd %%X
)
pause
