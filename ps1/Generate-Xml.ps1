[CmdletBinding()]
param()

Get-ChildItem -Directory | Foreach-Object -Process {
    $path = $_.FullName
    Write-Verbose $path
    $json = (Get-Content "$path\Graphing.json") | ConvertFrom-Json
    $ProjectName = $json.Projects[0].ProjectName

    [xml]$doc = '<Root></Root>'
    $root = $doc.SelectSingleNode('Root')
    foreach ($lang in @('G', 'J', 'C')) {
        $LangNode = $root.AppendChild($doc.CreateElement($lang))
        $ProjectNameNode = $LangNode.AppendChild($doc.CreateElement('ProjectName'))
        [void]$ProjectNameNode.AppendChild($doc.CreateTextNode($ProjectName))
    }
    $doc.Save("$path\Localization.xml")
}
