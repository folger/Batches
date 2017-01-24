[CmdletBinding()]
param(
    [string]$Title
)

if ($PSVersionTable.PSVersion.Major -gt 2) {
    Add-Type -AssemblyName System.Windows.Forms
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
        Description = $Title
        SelectedPath = $PSScriptRoot
    }
    if ($folderBrowser.ShowDialog() -eq "OK") {
        $folderBrowser.SelectedPath
    }
}
else {
    $app = New-Object -Com Shell.Application
    $folder = $app.BrowseForFolder(0, $Title, 0, "")
    $folder.Self.Path
}
