param($source, $target)
Compress-Archive -Path "$source\*.*" -DestinationPath "$target\$(Split-Path $source -Leaf).zip"
