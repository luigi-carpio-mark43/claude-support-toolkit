# Claude Support Toolkit Installer (PowerShell)
# Run from the root of this repo: .\install.ps1

$ErrorActionPreference = "Stop"

$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "=== Claude Support Toolkit Installer ===" -ForegroundColor Cyan
Write-Host ""

# Ensure ~/.claude exists
if (-not (Test-Path $ClaudeDir)) {
    New-Item -ItemType Directory -Path $ClaudeDir | Out-Null
}
if (-not (Test-Path (Join-Path $ClaudeDir "skills"))) {
    New-Item -ItemType Directory -Path (Join-Path $ClaudeDir "skills") | Out-Null
}

# Back up existing CLAUDE.md if present
$ClaudeMd = Join-Path $ClaudeDir "CLAUDE.md"
if (Test-Path $ClaudeMd) {
    $Timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $Backup = Join-Path $ClaudeDir "CLAUDE.md.backup.$Timestamp"
    Write-Host "Backing up existing CLAUDE.md to $Backup" -ForegroundColor Yellow
    Copy-Item $ClaudeMd $Backup
}

# Copy CLAUDE.md
Write-Host "Installing CLAUDE.md..."
Copy-Item (Join-Path $ScriptDir "CLAUDE.md") $ClaudeMd -Force

# Copy skills
Write-Host "Installing skills..."
$SkillsDir = Join-Path $ScriptDir "skills"
$SkillCount = 0

Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
    $SkillName = $_.Name
    $DestDir = Join-Path $ClaudeDir "skills" $SkillName

    if (-not (Test-Path $DestDir)) {
        New-Item -ItemType Directory -Path $DestDir | Out-Null
    }

    Copy-Item (Join-Path $_.FullName "*") $DestDir -Force
    Write-Host "  - $SkillName" -ForegroundColor Green
    $SkillCount++
}

Write-Host ""
Write-Host "Done! Installed:" -ForegroundColor Cyan
Write-Host "  - CLAUDE.md -> $ClaudeMd"
Write-Host "  - $SkillCount skills -> $(Join-Path $ClaudeDir 'skills')"
Write-Host ""
Write-Host "Open Claude Code in a Mark43 repo and try: /investigate <your issue>" -ForegroundColor Cyan
