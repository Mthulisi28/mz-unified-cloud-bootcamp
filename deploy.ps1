param (
    [Parameter(Mandatory=$true)][string]$SessionId,
    [Parameter(Mandatory=$true)][string]$Title,
    [Parameter(Mandatory=$true)][string]$YoutubeId,
    [Parameter(Mandatory=$true)][string]$SlidesPath,
    [Parameter(Mandatory=$true)][string]$NotesPath,
    [Parameter(Mandatory=$true)][string]$LabPath
)

# Move assets
Copy-Item $SlidesPath -Destination ".\$($SessionId)-slides.pdf" -Force
Copy-Item $NotesPath -Destination ".\$($SessionId)-notes.pdf" -Force
Copy-Item $LabPath -Destination ".\$($SessionId)-lab.pdf" -Force

# Update JSON
$json = Get-Content "session-registry.json" | ConvertFrom-Json
$json | Add-Member -MemberType NoteProperty -Name $SessionId -Value ([PSCustomObject]@{
    title = $Title
    youtubeId = $YoutubeId
    assets = @(
        @{label="Slides"; file="$($SessionId)-slides.pdf"},
        @{label="Notes"; file="$($SessionId)-notes.pdf"},
        @{label="Lab"; file="$($SessionId)-lab.pdf"}
    )
})
$json | ConvertTo-Json -Depth 10 | Set-Content "session-registry.json"

# Git
git add .
git commit -m "automation: deploy $SessionId"
git push origin main