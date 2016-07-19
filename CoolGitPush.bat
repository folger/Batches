@echo off

choice /c 12345 /m "How many commits?"

set numcommits=%errorlevel%

set patchfile=last_commit.patch
set devcodes=Dev_codes

pushd %develop%

git format-patch -%numcommits% --stdout > %patchfile%
move %patchfile% ..\%devcodes%\ > nul
echo Patch is generated and copy to %devcodes%

pushd ..\%devcodes%

echo Try to apply patch ...
git am -3 --keep-cr %patchfile% > nul
del %patchfile%

if %errorlevel%==0 (
	echo Patch is successfully applied, now push to origin ...
	git pull --rebase origin master
	if %errorlevel%==0 (
		git push origin master
		echo Done ~~~~
	)
)

popd
popd

pause
