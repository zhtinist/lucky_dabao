@echo off
chcp 65001 >nul
echo 开始部署加密网站...
echo.

REM 设置变量
set REPO=lucky_dabao
set PASSWORD=LuckyDabao2026

echo 1. 检查Git配置...
git config user.name >nul 2>&1
if errorlevel 1 (
    echo 请先配置Git用户信息：
    echo git config --global user.name "你的用户名"
    echo git config --global user.email "你的邮箱"
    pause
    exit /b 1
)

echo 2. 初始化Git仓库...
if not exist .git (
    git init
    git checkout -b source
) else (
    git checkout source 2>nul || git checkout -b source
)

echo 3. 添加文件到Git...
git add .
git commit -m "初始化加密网站项目" 2>nul

echo 4. 请手动完成以下步骤：
echo.
echo    a) 在GitHub上创建私有仓库 'lucky_dabao'
echo    b) 复制仓库的SSH或HTTPS地址
echo    c) 运行以下命令添加远程仓库：
echo       git remote add origin [你的仓库地址]
echo    d) 推送source分支：
echo       git push -u origin source
echo.
echo    e) 在GitHub仓库设置中：
echo       - 进入 Settings ^> Secrets and variables ^> Actions
echo       - 点击 "New repository secret"
echo       - Name: SITE_PASSWORD
echo       - Secret: %PASSWORD%
echo.
echo    f) 创建main分支并启用GitHub Pages：
echo       git checkout --orphan main
echo       git rm -rf .
echo       echo # 加密文件存放分支 ^> README.md
echo       git add README.md
echo       git commit -m "初始化main分支"
echo       git push -u origin main
echo       git checkout source
echo.
echo    g) 在GitHub仓库设置中启用Pages：
echo       - 进入 Settings ^> Pages
echo       - Source: Deploy from a branch
echo       - Branch: main
echo       - Folder: / (root)
echo.
echo 5. 完成后，你的网站将在以下地址可用：
echo    https://zhtinist.github.io/lucky_dabao/
echo    密码: %PASSWORD%
echo.
echo 后续使用：
echo - 将要加密的文件放入 "src" 目录
echo - 运行: git add . ^&^& git commit -m "添加新文件" ^&^& git push origin source
echo - GitHub Actions会自动加密并更新网站
echo.
pause