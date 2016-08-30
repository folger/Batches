@echo off
setlocal enableextensions
set me=%~n0
set parent=%~dp0

set repos=vimfiles ^
CodingFonts ^
DiscreteMarkov ^
RCLocalize ^
lucky28 ^
Cpp11 ^
ExportPythonProgramming ^
md ^
mp3play ^
folstools ^
clipbrdmngr ^
decodecaptchar ^
htsecdata ^
pk10 ^
djangobook

for %%x in (%repos%) do (
	echo === %%x ===
	if exist %%x (
		pushd %%x
		git pull --recurse-submodules=yes
		popd
	) else (
		git clone git@git.coding.net:folger6/%%%x.git --recursive
	)
)
pause
