# pull-all.ps1
# 一鍵同步所有 repo，兩台電腦切換時使用
# 使用前：把下方路徑換成你自己電腦的實際路徑

$repos = @(
    "C:\your-path\my-learning-journal",
    "C:\your-path\my-portfolio",
    "C:\your-path\my-templates"
)

foreach ($repo in $repos) {
    if (Test-Path "$repo\.git") {
        Write-Host "`n==> $repo" -ForegroundColor Cyan
        Set-Location $repo
        git pull
    } else {
        Write-Host "`n[跳過] $repo 不是 git repo 或路徑不存在" -ForegroundColor Yellow
    }
}

Write-Host "`n所有 repo 同步完成！" -ForegroundColor Green
