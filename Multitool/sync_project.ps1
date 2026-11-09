# CONFIGURATION
# $PSScriptRoot automatically gets the directory where THIS script file is saved
$SourceDir = $PSScriptRoot         

# Update this path to your exact destination (e.g., your RAM disk or permanent folder)
$TargetDir = "h:\dev\flash\2026\20261022172942" 

# Sync interval (checks for updates every X seconds)
$SyncIntervalSeconds = 444                 

Write-Host "Dynamic Sync Active!" -ForegroundColor Cyan
Write-Host "Mirroring from current directory: $SourceDir" -ForegroundColor Yellow
Write-Host "Target location: $TargetDir" -ForegroundColor Yellow

# Ensure target folder exists
if (!(Test-Path $TargetDir)) { New-Item -ItemType Directory -Path $TargetDir | Out-Null }

while ($true) {
    # /MIR mirrors the exact folder structure (deletes from target if deleted from source)
    # /XO excludes older files (only copies newly updated or modified files)
    robocopy "$SourceDir" "$TargetDir" /MIR /XO /NJH /NJS /NDL /NC /NS /NP | Out-Null
    
    Start-Sleep -Seconds $SyncIntervalSeconds
}
