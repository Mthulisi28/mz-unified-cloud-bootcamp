# ===============================
# SESSION REGISTRY AUTO BUILDER
# ===============================

$root = "C:\bootcamp\mz-unified-cloud-bootcamp"

$sessions = @()

function Add-Session($id, $title, $pathHint) {
    return @{
        id        = [string]$id
        title     = $title
        duration  = "TBD"
        color     = "#3b82f6"
        dimColor  = "#1e3a8a"
        youtubeId = "TBD"
        active    = $false
    }
}

# -------------------------------
# 1. CORE SESSIONS (sessions folder)
# -------------------------------
$sessionsPath = Join-Path $root "sessions"

Get-ChildItem $sessionsPath -File | ForEach-Object {
    if ($_.Name -match "session-(\d+)") {
        $id = $matches[1]

        $sessions += Add-Session `
            $id `
            "Session $id (Auto Imported)" `
            $_.FullName
    }
}

# -------------------------------
# 2. MODULE SESSIONS (week folders)
# -------------------------------
$weekPath = Join-Path $root "week-03"

Get-ChildItem $weekPath -Directory | ForEach-Object {
    if ($_.Name -match "session-(\d+)") {
        $id = $matches[1]

        $sessions += Add-Session `
            $id `
            ($_.Name -replace "-", " ") `
            $_.FullName
    }
}

# -------------------------------
# 3. SORT EVERYTHING PROPERLY
# -------------------------------
$sessions = $sessions | Sort-Object { [int]$_.id }

# -------------------------------
# 4. EXPORT FINAL REGISTRY
# -------------------------------
$json = $sessions | ConvertTo-Json -Depth 10

Set-Content `
    -Path (Join-Path $root "session-registry.json") `
    -Value $json `
    -Encoding UTF8

Write-Host "◈ REGISTRY BUILT SUCCESSFULLY ($($sessions.Count) sessions)" -ForegroundColor Green