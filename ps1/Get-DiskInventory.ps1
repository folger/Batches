<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory=$True, HelpMessage="Enter a computer name to query")]
  [Alias('HostName')]
  [string]$ComputerName,

  [ValidateSet(2, 3)]
  [int]$DriveType = 3
)
Write-Verbose "Connecting to $ComputerName"
Write-Verbose "Looking for drive type $DriveType"
Get-WmiObject -Class Win32_LogicalDisk `
 -ComputerName $computername `
 -Filter "drivetype = $drivetype" |
 Sort-Object -Property DeviceID |
 Select-Object -Property DeviceID,
 @{n='FreeSpace(MB)'; e={$_.FreeSpace / 1MB -as [int]}},
 @{n='Size(GB)'; e={$_.Size / 1GB -as [int]}},
 @{n='%Free'; e={$_.FreeSpace / $_.Size * 100 -as [int]}}
