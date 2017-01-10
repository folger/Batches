Get-ChildItem *.h,*.c,*.cpp -Recurse | Foreach-Object {
	$s = Get-Content $_
	$s | Out-File -Encoding UTF8 $_
	break
}
