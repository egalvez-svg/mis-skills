# PowerShell install.ps1 script for yii2-model-to-prisma

$skillName = "yii2-model-to-prisma"
$destBase = "$env:LOCALAPPDATA\antigravity\skills"
$destPath = Join-Path $destBase $skillName

# Ensure the destination directory exists
if (-not (Test-Path $destPath)) {
    New-Item -Path $destPath -ItemType Directory -Force
}

# Copy the skill files
Copy-Item -Path "$PSScriptRoot\SKILL.md" -Destination $destPath -Force
Copy-Item -Path "$PSScriptRoot\README.md" -Destination $destPath -Force

Write-Host "Skill '$skillName' installed successfully at: $destPath" -ForegroundColor Green
