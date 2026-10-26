$ErrorActionPreference = 'Stop'
$task = Get-ScheduledTask -TaskName 'AI-Storage-KB-Sync' -ErrorAction SilentlyContinue
if ($task) {
    Stop-ScheduledTask -TaskName 'AI-Storage-KB-Sync'
    Unregister-ScheduledTask -TaskName 'AI-Storage-KB-Sync' -Confirm:$false
}
Write-Host 'Auto-sync disabled. Local documents are preserved.'
