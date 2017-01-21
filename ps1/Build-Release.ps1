$Json = (Get-Content "$((Get-Item $MyInvocation.MyCommand.Name).BaseName).json") -Join "`n" | ConvertFrom-Json

$ComputerName = $Json.ComputerName
$Credential = $Json.Credential
$BuildBat = $Json.BuildBat
$Versions = $Json.Versions

$ValidVersion = $Versions.PSObject.Properties | Select-Object -ExpandProperty Name

$Host.ui.RawUI.WindowTitle = "Build Release on '$ComputerName'"

"Conneting to $ComputerName as $Credential ..."
$Session = New-PSSession -ComputerName $ComputerName -Credential $Credential

$Version = $Versions."$($ValidVersion[0])"
while ($True) {
  $DevFolder = $Version.Path
  $Cmd = Read-Host -Prompt "[$ComputerName]($DevFolder)"
  if ($Cmd.Length -eq 0) {break}
  if ($Cmd -in $ValidVersion) {
    $Version = $Versions."$Cmd"
    continue
  }
  if ($Cmd -like 'build *') {
    $Cmd = "$BuildBat $DevFolder $($Version.Config) $($Cmd.Replace('build ', ''))"
  }
  Invoke-Command -Session $Session -ScriptBlock ([ScriptBlock]::Create("cd $DevFolder;$Cmd"))
}
'Quiting ...'
