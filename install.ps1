$ErrorActionPreference = "Continue"

$RepoRoot = $PSScriptRoot
$UserHome = $HOME

Write-Host "--- Agent Skills Sync ---" -ForegroundColor Yellow

# 1. Update from GitHub if possible
if (Test-Path "$RepoRoot\.git") {
    Write-Host "Checking for updates in repository..." -ForegroundColor Cyan
    Set-Location $RepoRoot
    git pull origin main
}

# 2. Sync folders to Home
$Folders = @("agent", "opencode", "gemini")

foreach ($folder in $Folders) {
    $src = "$RepoRoot\$folder"
    $dest = "$UserHome\.$folder"
    
    if (Test-Path $src) {
        Write-Host "Syncing .$folder to user home..." -ForegroundColor Cyan
        if (-not (Test-Path $dest)) {
            New-Item -ItemType Directory -Path $dest -Force | Out-Null
        }
        # Copy-Item with -Force is idempotent and overwrites existing files
        Copy-Item -Path "$src\*" -Destination $dest -Recurse -Force
    }
}

Write-Host "`nSuccess! Your global AI skills are updated and in sync." -ForegroundColor Green
Write-Host "Note: If you are using Antigravity, you might need to refresh the UI."
