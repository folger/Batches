@echo off

REM set SOSHOME=%userprofile%\appdata\local\SourceGear\SourceOffSite

set @sos="c:\Program Files (x86)\SourceOffSite\soscmd.exe"

set @GetOrigin=1
set @GetLocalization=1
set @GetXF=0

if %@GetOrigin% == 1 (
    %@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
    -project $/current/SUPPORT/_90_All/Origin -verbose

    %@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
    -project $/current/SUPPORT/_90_All/OriginPro -verbose

    attrib -R * /S
)

if %@GetLocalization% == 1 (
    pushd Localization\E

    %@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
    -project $/current/SUPPORT/_90_All/Localization/E -recursive -verbose

    popd
)

if %@GetXF% == 1 (
    pushd H:\UFF\X-Functions

    %@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
    -project $/current/SUPPORT/_90_All/Origin/X-Functions -recursive -verbose

    %@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
    -project $/current/SUPPORT/_90_All/OriginPro/X-Functions -recursive -verbose

    attrib -R * /S

    popd
)

pause


