@echo off
for /d %%X in (*) do (
	echo Pushing %%X
	pushd %%X
	git push
	popd %%X
)
pause
