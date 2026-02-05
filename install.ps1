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
$FoldersMapping = @{
    "agent"    = ".$folder"
    "opencode" = ".$folder"
    "gemini"   = ".$folder"
    "cursor"   = "" # Special handling below
}

# Folders to iterate
$Folders = @("agent", "opencode", "gemini", "cursor")

foreach ($folder in $Folders) {
    if ($folder -eq "cursor") {
        # 2.1 Sync Cursor Rules Template
        $srcRules = "$RepoRoot\cursor\.cursorrules"
        $destRulesDir = "$UserHome\.cursor-skills"
        if (Test-Path $srcRules) {
            Write-Host "Syncing CursorRules template to $destRulesDir..." -ForegroundColor Cyan
            New-Item -ItemType Directory -Force -Path $destRulesDir | Out-Null
            Copy-Item -Path $srcRules -Destination $destRulesDir -Force
        }

        # 2.2 Sync Cursor Native Skills
        $srcSkills = "$RepoRoot\cursor\skills-cursor"
        $destSkills = "$UserHome\.cursor\skills-cursor"
        if (Test-Path $srcSkills) {
            Write-Host "Syncing Cursor Native Skills to $destSkills..." -ForegroundColor Cyan
            New-Item -ItemType Directory -Force -Path $destSkills | Out-Null
            Copy-Item -Path "$srcSkills\*" -Destination $destSkills -Recurse -Force
        }
    }
    else {
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
Write-Host "Note: For Cursor, you can now use /code-review and /smart-commit in Chat."
Write-Host "Note 2: You can also copy .cursorrules from ~/.cursor-skills to your project root."
