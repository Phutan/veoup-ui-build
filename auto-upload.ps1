<#
auto-upload.ps1
Auto uploader: push project to GitHub and trigger build workflow
#>

Write-Host "`nVeoUp Auto Uploader starting..." -ForegroundColor Cyan

$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Write-Host "ERROR: Git not found. Please install Git: https://git-scm.com/downloads" -ForegroundColor Red
    exit 1
}

$repoUrl = Read-Host "Enter GitHub repo URL (e.g. https://github.com/yourname/veoup-ui-build.git)"
if (-not $repoUrl) {
    Write-Host "No repo URL provided. Exiting." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "package.json")) {
    Write-Host "package.json not found — run this script in the project folder." -ForegroundColor Red
    exit 1
}

Write-Host "Initializing git repository..." -ForegroundColor Cyan
git init | Out-Null
git add .
# commit may fail if nothing to commit; ignore errors
try { git commit -m "Initial upload - VeoUp UI complete" | Out-Null } catch {}

git branch -M main

Write-Host "Setting remote origin to: $repoUrl" -ForegroundColor Cyan
git remote remove origin -f 2>$null
git remote add origin $repoUrl

Write-Host "Pushing to GitHub (origin/main)..." -ForegroundColor Cyan
try {
    git push -u origin main
    Write-Host "Upload successful!" -ForegroundColor Green
} catch {
    Write-Host "Push failed. Possible authentication issue." -ForegroundColor Red
    Write-Host "If prompted for username/password, use your GitHub username and a Personal Access Token (PAT) as password." -ForegroundColor Yellow
    Write-Host "See: https://github.com/settings/tokens" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Done. Open your GitHub repo and check the Actions tab to see the build workflow." -ForegroundColor Green
