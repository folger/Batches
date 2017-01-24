$title = "Select App to work"
if ($PSVersionTable.PSVersion.Major -gt 2) {
    Add-Type -AssemblyName System.Windows.Forms
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
        Description = $title
        SelectedPath = $pSScriptRoot
    }
    if ($folderBrowser.ShowDialog() -eq "OK") {
        $folderBrowser.SelectedPath
    }
}
else {
    $app = New-Object -com Shell.Application
    $folder = $app.BrowseForFolder(0, $title, 0, "")
    $folder.Self.Path
}
