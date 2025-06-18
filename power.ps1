<#
.SYNOPSIS
  Creates or updates index.html, commits, and pushes to GitHub Pages.
#>

param(
    [string]$CommitMessage = "Add initial index.html"
)

# 1. Confirm this is a Git repo
if (-not (Test-Path ".git")) {
    Write-Error "Error: This folder is not a Git repository. Clone your repo first."
    exit 1
}

# 2. Write index.html
$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Game Store</title>
</head>
<body>
  <h1>Welcome to My Game Store!</h1>
  <p>This is a placeholder page. We will add more soon.</p>
</body>
</html>
"@

Set-Content -Path "index.html" -Value $html -Encoding UTF8
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to write index.html"
    exit 1
}
Write-Host "[OK] index.html created or updated"

# 3. Stage changes
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Error "git add failed"
    exit 1
}
Write-Host "[OK] Changes staged"

# 4. Commit
git commit -m $CommitMessage
if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] Committed with message: '$CommitMessage'"
} else {
    Write-Host "Info: Nothing to commit or commit failed"
}

# 5. Push to main
git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Error "git push failed"
    exit 1
}
Write-Host "[OK] Pushed to origin/main"
