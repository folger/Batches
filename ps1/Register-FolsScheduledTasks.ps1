$taskpath = 'folgers'
$names = @('DeleteOldSupportFiles',
          'GetPDBs',
          'CopyBuild',
          'GetSupport',
          'StartupBuild'
          )
foreach ($name in $names) {
  Unregister-ScheduledTask -TaskName $name -Confirm:$False -ErrorAction SilentlyContinue
}
$triggers = @((New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 1pm),
            (New-ScheduledTaskTrigger -Daily -At 9am),
            (New-ScheduledTaskTrigger -Daily -At '9:25 am'),
            (New-ScheduledTaskTrigger -Daily -At 10am),
            (New-ScheduledTaskTrigger -Daily -At '8:50 am')
            )
$actions = @((New-ScheduledTaskAction -Execute ($Env:folscode + '\Batches\DeleteOldSupports.bat')),
            (New-ScheduledTaskAction -Execute ($Env:folscode + '\Batches\GetDebugFiles.bat') -Argument 'buildcopy GetOriginRelease15 94 pdb'),
            (New-ScheduledTaskAction -Execute ($Env:folscode + '\Batches\copy_to_fs1.bat') -Argument '"\\poly\Dropbox\Builds-Origin\94\" 94'),
            (New-ScheduledTaskAction -Execute ($Env:folscode + '\Batches\GetSupport.bat') -WorkingDirectory 'G:\F_C_VC32'),
            (New-ScheduledTaskAction -Execute ($Env:folscode + '\Batches\BuildOnWorkDay.bat') -Argument 'Win32 Debug 1800')
            )

for ($i=0; $i -lt $names.count; $i++) {
  Register-ScheduledTask -TaskName $names[$i] -TaskPath $taskpath -Trigger $triggers[$i] -Action $actions[$i]
}
