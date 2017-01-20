[CmdletBinding()]
param (
  [Parameter(Mandatory=$True)]
  [string]$ComputerName,

  [Parameter(Mandatory=$True)]
  [string]$Credential,

  [Parameter(Mandatory=$True)]
  [string]$BuildBat
)

"Conneting to $ComputerName ..."
$Session = New-PSSession -ComputerName $ComputerName -Credential $Credential

$Host.ui.RawUI.WindowTitle = "Build Release on '$ComputerName'"

$ValidVersion = @('94', '95')
$Version = '94'
$DevFolders = @{'94' = 'E:\Dev'; '95' = 'E:\Dev_95'}
$Configs = @{'94' = 'Release'; '95' = 'UnicodeRelease'}

while ($True) {
  $DevFolder = $DevFolders[$Version]
  $Cmd = Read-Host -Prompt "[$ComputerName]($DevFolder)"
  if ($Cmd.Length -eq 0) {break}
  if ($Cmd -in $ValidVersion) {
    $Version = $Cmd
    continue
  }
  if ($Cmd -like 'build *') {
    $Cmd = "$BuildBat $DevFolder $($Configs[$Version]) $($Cmd.Replace('build ', ''))"
  }
  Invoke-Command -Session $Session -ScriptBlock ([ScriptBlock]::Create("cd $DevFolder;$Cmd"))
}

'Quiting ...'
Remove-PSSession $Session
