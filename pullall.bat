@echo off
for /d %%X in (*) do (
	echo Pulling %%X
	pushd %%X
	git pull
	popd %%X
)
set @folders=%home%\vimfiles ^
C:\Python33\Lib\site-packages\folstools
for %%X in (%@folders%) do (
	echo Pulling %%X
	pushd %%X
	git pull
	popd %%X
)
pause
