function MyInvoke-Command($Cmd) {
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($Cmd))
}
function mn($Cmd) {
    MyInvoke-Command -Cmd "Get-Help $Cmd -Full | gvim -"
}
function Simulate-Command($Cmd, $MyArgs) {
    $args2 = @()
    foreach ($arg in $MyArgs) {
        if ($arg -notlike '/?') {
            $arg = "`"$arg`""
        }
        $args2 += $arg
    }
    MyInvoke-Command -Cmd "cmd /c $Cmd $($args2 -join ' ')"
}
function mklink() {
    Simulate-Command -Cmd mklink -MyArgs $args
}
