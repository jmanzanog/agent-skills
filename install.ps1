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
$Folders = @("agent", "opencode", "gemini", "cursor")

foreach ($folder in $Folders) {
    $src = "$RepoRoot\$folder"
    # For .cursor we might want to keep the name or map to .cursor-skills
    $destName = if ($folder -eq "cursor") { "cursor-skills" } else { ".$folder" }
    $dest = "$UserHome\$destName"
    
    if (Test-Path $src) {
        Write-Host "Syncing $folder config to $dest..." -ForegroundColor Cyan
        if (-not (Test-Path $dest)) {
            New-Item -ItemType Directory -Path $dest -Force | Out-Null
        }
        
        if ($folder -eq "cursor") {
            # Copy contents of cursor/ to .cursor-skills/
            Copy-Item -Path "$src\*" -Destination $dest -Recurse -Force
        }
        else {
            Copy-Item -Path "$src\*" -Destination $dest -Recurse -Force
        }
    }
}

Write-Host "`nSuccess! Your global AI skills are updated and in sync." -ForegroundColor Green
Write-Host "Note: For Cursor, copy .cursorrules from ~/.cursor-skills to your project root."
