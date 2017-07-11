[CmdletBinding()]
param (
    [Parameter(Mandatory=$True,
              HelpMessage="Enter Origin EXE folder")]
    [String]$ExePath,
    [Int]$WithExt = 0
)
Get-ChildItem -Path $ExePath -Filter "Origin*.exe" | Foreach-Object {
    $version= $_.VersionInfo.ProductVersion
}
if ($version) {
    Get-ChildItem -Path $ExePath | Where-Object {-not $_.PSIsContainer} | Foreach-Object {
        if ($version -eq $_.VersionInfo.ProductVersion) {
            if ($WithExt) {
                $_.Name
            } else {
                $_.BaseName
            }
        }
    }
}
