@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set @sos="c:\Program Files (x86)\SourceOffSite\soscmd.exe"

set @originpath=.

echo.
echo *********************Geting Origin*********************
echo.

pushd %@originpath%

%@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
-project $/current/SUPPORT/_90_All/Origin -recursive -verbose

echo.
echo *********************Geting OriginPro*********************
echo.

%@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
-project $/current/SUPPORT/_90_All/OriginPro -recursive -verbose

popd

echo.
echo *********************Geting Localization*********************
echo.

mkdir %@originpath%\Localization
pushd %@originpath%\Localization

%@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
-project $/current/SUPPORT/_90_All/Localization -recursive -verbose

popd

echo.
echo ********************* Done !!! *********************
echo.
pause
