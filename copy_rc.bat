@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

if exist od.rc copy od.rc "%develop%\Source\vc32\od"
if exist oErrMsg.rc copy oErrMsg.rc "%develop%\Source\vc32\oErrMsg"
if exist OKern96.rc copy OKern96.rc "%develop%\Source\vc32\OKern96"
if exist Origin50.rc copy Origin50.rc "%develop%\Source\vc32\Origin50"
if exist OUser.rc copy OUser.rc "%develop%\Source\vc32\OUser"
if exist ODlg.rc copy ODlg.rc "%develop%\Source\DDK Tools\ODlg"
if exist ODlg8.rc copy ODlg8.rc "%develop%\Source\DDK Tools\ODlg8"
if exist okUtil.rc copy okUtil.rc "%develop%\Source\MFC\okUtil\okUtil.rc"
if exist OIDE.rc copy OIDE.rc "%develop%\Source\MFC\oide\OIDE.rc"
