$vars = @{'Develop'='D:\Dev';
    'folscode'='D:\folscode';
    'HOME'="$Env:USERPROFILE";
    'Diff'='D:\BoxSync\Windows\Beyond Compare 3\BComp.exe'
}

$user = [System.EnvironmentVariableTarget]::User

$vars.Keys | Foreach-Object {
    [Environment]::SetEnvironmentVariable($_, $vars[$_], $user)
}

$paths = @(
    [Environment]::GetEnvironmentVariable('Path', $user),
    'C:\Python33\Scripts',
    'D:\Git\cmd',
    'D:\Git\bin',
    'F:\vim_min\vim80'
)
[Environment]::SetEnvironmentVariable('Path', $paths -join ';', $user)
