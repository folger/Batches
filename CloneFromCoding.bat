@echo off

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
pk10

for %%x in (%repos%) do (
	git clone git@git.coding.net:folger6/%%%x.git --recursive
)