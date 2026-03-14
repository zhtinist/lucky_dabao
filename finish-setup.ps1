# 完成加密网站设置
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "           完成加密网站设置" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 提交当前更改
Write-Host "提交当前更改..." -ForegroundColor Yellow
git add .
git commit -m "完成项目配置，使用src目录，准备部署"

Write-Host ""
Write-Host "✅ 本地设置完成！" -ForegroundColor Green
Write-Host ""
Write-Host "接下来请按照 DEPLOY_STEPS.md 中的步骤：" -ForegroundColor Cyan
Write-Host "1. 创建GitHub仓库 (lucky_dabao)" -ForegroundColor White
Write-Host "2. 添加远程仓库并推送" -ForegroundColor White
Write-Host "3. 设置GitHub Secrets" -ForegroundColor White
Write-Host "4. 启用GitHub Pages" -ForegroundColor White
Write-Host ""
Write-Host "网站将在以下地址可用：" -ForegroundColor Green
Write-Host "https://zhtinist.github.io/lucky_dabao/" -ForegroundColor Yellow
Write-Host "密码: LuckyDabao2026" -ForegroundColor Yellow
Write-Host ""

# 显示当前项目状态
Write-Host "当前项目文件：" -ForegroundColor Cyan
Get-ChildItem -Name | Where-Object { $_ -notlike ".*" }
Write-Host ""
Write-Host "src目录内容：" -ForegroundColor Cyan
Get-ChildItem src -Name
Write-Host ""

Read-Host "按回车键继续..."