function mn($cmd) {
  Invoke-Command -ScriptBlock ([ScriptBlock]::Create("Get-Help $cmd -Full | gvim - -c `"w! $Env:Temp\help.txt`""))
}
