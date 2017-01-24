[CmdletBinding()]
param()

Get-ChildItem -Directory | Foreach-Object -Process {
    $path = $_.FullName
    Write-Verbose $path
    $json = (Get-Content "$path\Graphing.json") | ConvertFrom-Json
    $projectName = $json.Projects[0].ProjectName

    [xml]$doc = '<Root></Root>'
    $root = $doc.SelectSingleNode('Root')
    foreach ($lang in @('G', 'J', 'C')) {
        $langNode = $root.AppendChild($doc.CreateElement($lang))
        $projectNameNode = $langNode.AppendChild($doc.CreateElement('ProjectName'))
        [void]$projectNameNode.AppendChild($doc.CreateTextNode($projectName))
    }
    $doc.Save("$path\Localization.xml")
}
