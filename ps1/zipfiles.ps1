param($p1, $p2)
Compress-Archive -Path ($p1 + '\*.*') -DestinationPath ($p2 + '\' + (Split-Path $p1 -Leaf) + '.zip')
