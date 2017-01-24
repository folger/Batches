$json = (Get-Content "$((Get-Item $MyInvocation.MyCommand.Name).BaseName).json") -join "`n" | ConvertFrom-Json

$computerName = $json.ComputerName
$credential = $json.Credential
$buildBat = $json.BuildBat
$versions = $json.Versions
$validVersions = $versions.PSObject.Properties.Name

$Host.ui.RawUI.WindowTitle = "Build Release on '$computerName'"

"Conneting to $computerName as $credential ..."
$session = New-PSSession -ComputerName $computerName -Credential $credential

$version = $versions."$($validVersions[0])"
while ($true) {
    $devFolder = $version.RemotePath
    $cmd = Read-Host -Prompt "[$computerName]($devFolder)"
    if ($cmd.Length -eq 0) {break}
    if ($cmd -in $validVersions) {
        $version = $versions."$cmd"
        continue
    }
    if ($cmd -eq 'gcp') {
        git -C $version.LocalPath status -s | Foreach-Object -Process {
            $f = $_.Substring(3)
            $src = "$($version.LocalPath)\$f"
            $dest = "\\$computerName\$($version.RemotePath)\$f".Replace(':', '$')
            Copy-Item -Destination $dest -LiteralPath $src
        }
        continue
    }
    if ($cmd -in @('cls')) {
        Invoke-Command -ScriptBlock ([ScriptBlock]::Create($cmd))
        continue
    }
    if ($cmd -like 'build *') {
        $cmd = "$buildBat $devFolder $($version.Config) $($cmd.Replace('build ', ''))"
    }
    Invoke-Command -Session $session -ScriptBlock ([ScriptBlock]::Create("cd $devFolder;$cmd"))
}
'Quiting ...'
