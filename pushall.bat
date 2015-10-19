@echo off
for /d %%X in (*) do (
	echo Pushing %%X
	pushd %%X
	git push
	popd %%X
)
set @folders=%home%\vimfiles ^
C:\Python33\Lib\site-packages\folstools
for %%X in (%@folders%) do (
	echo Pushing %%X
	pushd %%X
	git push
	popd %%X
)
pause
