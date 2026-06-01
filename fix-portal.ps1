# ═════════════════════════════════════════════
# PORTAL NORMALIZATION PIPELINE
# Session Fix + Injection Cleanup + Standardization
# ═════════════════════════════════════════════

$files = @(
    ".\index.html",
    ".\MZ-UCA-PORTAL\index.html"
)

Write-Host "■ Starting Portal Normalization Pipeline..." -ForegroundColor Cyan

foreach ($file in $files) {

    if (!(Test-Path $file)) {
        Write-Host "⚠ Missing: $file" -ForegroundColor Yellow
        continue
    }

    Write-Host "`n✔ Processing: $file" -ForegroundColor Green

    $content = Get-Content $file -Raw

    # ─────────────────────────────
    # 1. REMOVE QUIZ INJECTION BLOCKS
    # ─────────────────────────────
    $content = $content -replace '(?s)<div class="sc active" style="--dcol: var\(--gold\);">.*?Download Session 8 Slides.*?</div>\s*</div>', ''

    # ─────────────────────────────
    # 2. REMOVE DUPLICATE SESSION 8 BLOCKS
    # ─────────────────────────────
    $content = $content -replace '(?s)<div class="sc active"[^>]*>.*?Network Security & Governance.*?</div>\s*</div>', ''

    # ─────────────────────────────
    # 3. REMOVE OLD SESSION 9 BLOCKS (if any)
    # ─────────────────────────────
    $content = $content -replace '(?s)<div class="sc active"[^>]*>.*?Cloud Migration.*?</div>\s*</div>', ''

    # ─────────────────────────────
    # 4. FORCE CLEAN SESSION 9 BLOCK
    # ─────────────────────────────
    $session9 = @'
<div class="sc active" style="--dcol:#1e40af;--ddim:#1e3a8a;">
  <div class="sc-head">
    <div class="sc-title-block">
      <span class="st1">Cloud Migration</span>
      <span class="st2" style="color:#3b82f6;">Strategy & Execution</span>
    </div>
    <p class="sc-sub">6Rs Framework · Discovery · Application Assessment</p>
  </div>

  <div class="sc-resources">
    <a href="#" onclick="vaultOpen('https://mthulisi28.github.io/mz-unified-cloud-bootcamp/assets/SESSION%209%20CLOUD%20MIGRATION%20CONCEPTS%20%26%20MODERNIZATION.pdf','View Slides','L3');return false;" class="rl">
      <span class="ri">📄</span>View Slides
    </a>

    <a href="#" onclick="vaultOpen('https://mthulisi28.github.io/mz-unified-cloud-bootcamp/assets/SESSION%209%20GITHUB%20LABS.pdf','GitHub Lab','L3');return false;" class="rl">
      <span class="ri">💻</span>GitHub Lab
    </a>

    <a href="#" onclick="vaultOpen('https://mthulisi28.github.io/mz-unified-cloud-bootcamp/assets/SESSION%209%20FINAL%20LAB.pdf','Final Lab','L3');return false;" class="rl">
      <span class="ri">📝</span>Final Lab
    </a>
  </div>

  <div class="sc-week">Week 3 · PROFESSIONAL Division</div>
</div>
'@

    # ─────────────────────────────
    # 5. INSERT SESSION 9 CLEANLY
    # ─────────────────────────────
    if ($content -match "Cloud Migration") {
        $content = $content -replace '(?s)<div class="sc active" style="--dcol:#1e40af;.*?</div>\s*</div>', $session9
    }

    # ─────────────────────────────
    # 6. WRITE BACK CLEAN FILE
    # ─────────────────────────────
    Set-Content -Path $file -Value $content -Force

    Write-Host "✔ Normalized successfully: $file" -ForegroundColor Green
}

# ─────────────────────────────
# 7. GIT SYNC
# ─────────────────────────────
Write-Host "`n■ Committing changes..." -ForegroundColor Cyan

git add .
git commit -m "automation(portal): session normalization pipeline (S8-S9 cleanup + stabilization)"
git push origin main

Write-Host "`n■ Deployment complete ✔" -ForegroundColor Cyan