@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

title Cool Git Push

choice /c 12345 /m "How many commits?"

set numcommits=%errorlevel%

set patchfile=commits.patch
set devcodes=Dev_codes

pushd %develop%

git format-patch -%numcommits% --stdout > ..\%devcodes%\%patchfile%
echo Patch is generated and copy to %devcodes%

pushd ..\%devcodes%

echo Try to fetch latest codes ...
git pull origin master
echo Try to apply patch ...
git am -3 --keep-cr %patchfile%
del %patchfile%

if %errorlevel%==0 (
	echo Patch is successfully applied, now push to origin ...
	git push origin master
	echo Done ~~~~
)

popd
popd

pause
