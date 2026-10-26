param(
    [Parameter(Mandatory=$true)][string]$RepoPath,
    [Parameter(Mandatory=$true)][string]$GitPath
)
$ErrorActionPreference = 'Stop'
$env:GIT_TERMINAL_PROMPT = '0'
$logDir = Join-Path $env:LOCALAPPDATA 'AI-Storage-Sync'
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$log = Join-Path $logDir 'sync.log'
function Write-Log([string]$Message) {
    if ((Test-Path $log) -and (Get-Item $log).Length -gt 1MB) {
        Move-Item $log "$log.previous" -Force
    }
    Add-Content -Path $log -Value "$(Get-Date -Format s) $Message" -Encoding UTF8
    Write-Output $Message
}
function Invoke-Git([string[]]$GitArgs) {
    $result = & $GitPath -C $RepoPath @GitArgs 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Git failed: $($result -join ' ')" }
    return $result
}
try {
    $origin = (Invoke-Git @('remote','get-url','origin')) -join ''
    if ($origin -ne 'https://github.com/dy-nts/AI_Storage.git') { throw 'Unexpected origin. No update performed.' }
    $branch = (Invoke-Git @('branch','--show-current')) -join ''
    if ($branch -ne 'main') { throw 'Switch to main before syncing.' }
    $changes = Invoke-Git @('status','--porcelain','--untracked-files=all')
    if ($changes) { throw 'Local edits or untracked files found. Sync paused; files preserved.' }
    Invoke-Git @('-c','http.lowSpeedLimit=1','-c','http.lowSpeedTime=30','fetch','--quiet','origin','main') | Out-Null
    $ahead = (Invoke-Git @('rev-list','--count','origin/main..HEAD')) -join ''
    if ($ahead -ne '0') { throw 'Local commits found. Review them manually; no upload performed.' }
    Invoke-Git @('merge','--ff-only','origin/main') | Out-Null
    Write-Log 'OK: GitHub changes received.'
    exit 0
} catch {
    Write-Log "STOP: $($_.Exception.Message)"
    exit 1
}
