$ErrorActionPreference = "Stop"

$RepoRoot = $PSScriptRoot
$UserHome = $HOME

Write-Host "Installing Agent Skills from: $RepoRoot"
Write-Host "Target: $UserHome"

# 1. Install .agent
$AgentSrc = "$RepoRoot\agent"
$AgentDest = "$UserHome\.agent"
if (Test-Path $AgentSrc) {
    Write-Host "Syncing .agent..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force -Path $AgentDest | Out-Null
    Copy-Item -Path "$AgentSrc\*" -Destination $AgentDest -Recurse -Force
}

# 2. Install .opencode
$OpenCodeSrc = "$RepoRoot\opencode"
$OpenCodeDest = "$UserHome\.opencode"
if (Test-Path $OpenCodeSrc) {
    Write-Host "Syncing .opencode..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force -Path $OpenCodeDest | Out-Null
    Copy-Item -Path "$OpenCodeSrc\*" -Destination $OpenCodeDest -Recurse -Force
}

Write-Host "Installation Complete! Skills are now available globally." -ForegroundColor Green
Write-Host "Restart your IDE/Agent to pick up changes."
