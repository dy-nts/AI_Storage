$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$git = (Get-Command git -ErrorAction Stop).Source
$origin = & $git -C $repo remote get-url origin
if ($LASTEXITCODE -ne 0 -or $origin -ne 'https://github.com/dy-nts/AI_Storage.git') { throw 'Run from the AI_Storage git clone.' }
$store = Join-Path $env:LOCALAPPDATA 'AI-Storage-Sync'
New-Item -ItemType Directory -Path $store -Force | Out-Null
$worker = Join-Path $store 'Sync-KB.ps1'
# Run a local copy; changes to scripts on GitHub do not replace the scheduled worker.
Copy-Item (Join-Path $PSScriptRoot 'Sync-KB.ps1') $worker -Force
$exe = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
$argsText = '-NoProfile -NonInteractive -ExecutionPolicy Bypass -File "{0}" -RepoPath "{1}" -GitPath "{2}"' -f $worker,$repo,$git
$action = New-ScheduledTaskAction -Execute $exe -Argument $argsText -WorkingDirectory $repo
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 5)
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$principal = New-ScheduledTaskPrincipal -UserId $user -LogonType Interactive -RunLevel Limited
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Minutes 3) -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName 'AI-Storage-KB-Sync' -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null
Start-ScheduledTask -TaskName 'AI-Storage-KB-Sync'
Write-Host "Enabled: check every 5 minutes while signed in. Log: $store\sync.log"
Write-Host "Obsidian vault: $repo\automotive-mcu"
