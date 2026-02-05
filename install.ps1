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

# 2. Sync Folders
$Folders = @("agent", "opencode", "gemini", "cursor")

foreach ($folder in $Folders) {
    if ($folder -eq "cursor") {
        # 2.1 Sync Cursor Commands (Global)
        $srcCommands = "$RepoRoot\cursor\commands"
        $destCommands = "$UserHome\.cursor\commands"
        if (Test-Path $srcCommands) {
            Write-Host "Syncing Global Cursor Commands..." -ForegroundColor Cyan
            New-Item -ItemType Directory -Force -Path $destCommands | Out-Null
            Copy-Item -Path "$srcCommands\*" -Destination $destCommands -Recurse -Force
        }

        # 2.2 Sync Cursor Rules Template (Manual Copy if needed)
        $srcRules = "$RepoRoot\cursor\.cursorrules"
        $destRulesDir = "$UserHome\.cursor-skills"
        if (Test-Path $srcRules) {
            Write-Host "Syncing .cursorrules template to ~/.cursor-skills..." -ForegroundColor Cyan
            New-Item -ItemType Directory -Force -Path $destRulesDir | Out-Null
            Copy-Item -Path $srcRules -Destination $destRulesDir -Force
        }
    }
    else {
        # Standard .folder sync
        $src = "$RepoRoot\$folder"
        $dest = "$UserHome\.$folder"
        if (Test-Path $src) {
            Write-Host "Syncing .$folder to user home..." -ForegroundColor Cyan
            New-Item -ItemType Directory -Force -Path $dest | Out-Null
            Copy-Item -Path "$src\*" -Destination $dest -Recurse -Force
        }
    }
}

Write-Host "`nSuccess! Your global AI skills are updated and in sync." -ForegroundColor Green
Write-Host "Note: For Cursor, you can now use /review and /commit in Chat globally."
