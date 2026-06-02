# 1. Environment Configurations
$htmlPath     = "C:\bootcamp\mz-unified-cloud-bootcamp\index.html"
$registryPath = "C:\bootcamp\mz-unified-cloud-bootcamp\session-registry.json"
$startMarker  = ""
$endMarker    = ""

# 2. Ingest Data Elements
if (-not (Test-Path $registryPath)) {
    Write-Error "CRITICAL: session-registry.json not found."
    return
}
$jsonRaw = Get-Content -Path $registryPath -Raw -Encoding UTF-8
$targetSessions = ConvertFrom-Json -InputObject $jsonRaw

# 3. Compile the Dynamic Component Payload and Javascript Map Objects
$compiledPayload = ""
$jsMapEntries = @()

foreach ($session in $targetSessions) {
    $isActive = if ($session.active) { "active" } else { "" }
    # Inject onclick parameter pointing natively to the session database mapping
    $compiledPayload += @"
        <div class="sc $isActive" style="--dcol: $($session.color); --ddim: $($session.dimColor);" onclick="loadVideo('$($session.id)')">
            <div class="sc-head">
                <span class="sc-number">◆ Session $($session.id)</span>
                <span class="sc-title">$($session.title)</span>
                <span class="sc-duration">◈ $($session.duration)</span>
            </div>
        </div>`n
"@
    # Dynamically build the JS dictionary keys from data rows
    $jsMapEntries += "            `"$($session.id)`": `"$($session.youtubeId)`""
}

$jsMapString = $jsMapEntries -join ",`n"

# 4. Generate the Fixed Presentation Structural Template
$templateHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS Solutions Architect Associate Master Portal</title>
    <style>
        :root { --bg: #060913; --card: #0b1120; --border: #1e293b; --text: #f3f4f6; }
        body { background: var(--bg); color: var(--text); font-family: system-ui, -apple-system, sans-serif; padding: 2rem; margin: 0; }
        .container { max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
        @media (max-width: 968px) { .container { grid-template-columns: 1fr; } }
        
        .player-pane { position: sticky; top: 2rem; height: fit-content; }
        .video-wrapper { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; background: #000; border-radius: 8px; border: 1px solid var(--border); box-shadow: 0 20px 25px -5px rgba(0,0,0,0.5); }
        .video-wrapper iframe, .video-wrapper .placeholder { position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none; }
        .video-wrapper .placeholder { display: flex; flex-direction: column; align-items: center; justify-content: center; color: #64748b; background: #020617; text-align: center; padding: 2rem; box-sizing: border-box; }
        
        .session-pane { height: calc(100vh - 4rem); overflow-y: auto; padding-right: 0.5rem; }
        .session-pane::-webkit-scrollbar { width: 6px; }
        .session-pane::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
        
        h2 { font-size: 1.25rem; font-weight: 600; letter-spacing: 0.05em; margin-bottom: 1.5rem; color: #fff; border-bottom: 1px solid var(--border); padding-bottom: 0.75rem; }
        
        .sc { background: var(--card); border: 1px solid var(--border); border-left: 4px solid var(--dcol); margin-bottom: 1rem; border-radius: 6px; padding: 1.25rem; cursor: pointer; transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1); }
        .sc:hover { transform: translateX(4px); border-color: var(--dcol); }
        .sc.active { background: var(--ddim); border-color: var(--dcol); box-shadow: 0 0 20px -5px var(--dcol); }
        .sc-head { display: flex; justify-content: space-between; align-items: center; gap: 1rem; }
        .sc-number { font-weight: 700; color: var(--dcol); font-size: 0.875rem; text-transform: uppercase; }
        .sc-title { flex: 1; font-weight: 500; font-size: 0.95rem; line-height: 1.4; color: #e2e8f0; }
        .sc-duration { color: #64748b; font-size: 0.85rem; white-space: nowrap; font-variant-numeric: tabular-nums; }
    </style>
</head>
<body>
    <div class="container">
        <div class="player-pane">
            <h2>◈ BROADCAST RUNTIME CONTROLLER</h2>
            <div class="video-wrapper">
                <div id="video-target" class="placeholder">
                    <span style="font-size: 2rem; margin-bottom: 0.5rem;">◆</span>
                    <p style="margin: 0; font-size: 0.95rem;">Select an active session architecture node from the track menu to initialize video broadcast.</p>
                </div>
            </div>
        </div>

        <div class="session-pane">
            <h2>◈ UNIFIED CLOUD ARCHITECTURE TRACK</h2>
            $startMarker
$compiledPayload
            $endMarker
        </div>
    </div>

    <script>
        // Auto-Generated Video Routing Engine Map
        const videoMap = {
$jsMapString
        };

        function loadVideo(sessionId) {
            document.querySelectorAll('.sc').forEach(card => card.classList.remove('active'));
            
            const clickedCard = event.currentTarget;
            if (clickedCard) clickedCard.classList.add('active');
            
            const target = document.getElementById('video-target');
            const videoId = videoMap[sessionId];
            
            if (videoId) {
                target.outerHTML = `<iframe id="video-target" src="https://www.youtube.com/embed/\${videoId}?autoplay=1&rel=0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>`;
            }
        }
    </script>
</body>
</html>
"@

# 5. Flush Securely to Production Target Node
Set-Content -Path $htmlPath -Value $templateHtml -Encoding UTF-8
Write-Host "◈ [SUCCESS] Production portal compiled with fully mapped data streams ($($targetSessions.Count) elements)." -ForegroundColor Green
