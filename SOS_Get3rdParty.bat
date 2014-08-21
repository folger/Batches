@echo off

set @sos="c:\Program Files (x86)\SourceOffSite\soscmd.exe"

set @originpath=.

set @paths=$/current/SUPPORT/_3rdParty/Image/GIF ^
            $/current/SUPPORT/_3rdParty/Image/Inso ^
            $/current/SUPPORT/_3rdParty/Image/InsoGif ^
            $/current/SUPPORT/_3rdParty/Image/Lead17 ^
            $/current/SUPPORT/_3rdParty/Image/SoftDev ^
            $/current/SUPPORT/_3rdParty/Image/TX ^
            $/Current/Support/_3rdParty/Image_32And64/SoftDev ^
            $/Current/Support/_3rdParty/Image_x64/Lead17/x64 ^
            $/Current/Support/_3rdParty/Image_x64/SoftDev ^
            $/Current/Support/_3rdParty/pClamp/32ANd64 ^
            $/Current/Support/_3rdParty/SameBinaryName ^
            $/Current/Support/_3rdParty/Thermo ^
            $/Current/Support/_3rdParty/MoreDLLS ^
            $/current/SUPPORT/_90_All/OriginBinaries32 ^
            $/current/SUPPORT/_90_All/OriginBinaries64

pushd %@originpath%

for %%a in (%@paths%) do (
  %@sos% -command GetProject -server 207.180.39.174:8080 -name folger -password "" -alias vss_dev ^
  -project %%a -recursive -verbose
)

popd

echo.
echo ********************* Done !!! *********************
echo.
pause
