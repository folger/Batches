[CmdletBinding()]
param (
    [Parameter(Mandatory=$True,
              HelpMessage="Enter Origin EXE folder")]
    [String]$ExePath
)
Get-ChildItem -Path $ExePath -Filter "Origin*.exe" | Foreach-Object {
    $version= $_.VersionInfo.ProductVersion
}
Get-ChildItem -Path $ExePath | Where-Object {-not $_.PSIsContainer} | Foreach-Object {
    if ($version -eq $_.VersionInfo.ProductVersion) {
        $_.BaseName
    }
}
