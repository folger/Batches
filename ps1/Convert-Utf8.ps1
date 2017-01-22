Get-ChildItem -Path . -Include *.h,*.c,*.cpp -Recurse | Foreach-Object -Process {
    $s = Get-Content -Path $_
    $s | Out-File -Encoding UTF8 -FilePath $_
    break
}
