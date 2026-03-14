@echo off
chcp 65001 >nul
echo ========================================
echo           加密网站手动部署脚本
echo ========================================
echo.

REM 设置变量
set REPO=lucky_dabao
set PASSWORD=LuckyDabao2026

echo 步骤 1: 提交当前更改到本地仓库
git add .
git commit -m "更新项目，使用src目录替代中文文件夹名"

echo.
echo 步骤 2: 请手动完成以下操作
echo ----------------------------------------
echo 1. 访问 https://github.com/new
echo 2. Repository name: %REPO%
echo 3. 设置为 Private
echo 4. 不要勾选任何初始化选项
echo 5. 点击 "Create repository"
echo.
echo 6. 复制仓库地址，然后运行：
echo    git remote add origin [你的仓库地址]
echo    git push -u origin source
echo.
pause

echo.
echo 步骤 3: 设置远程仓库（请输入你的仓库地址）
set /p REPO_URL="请输入GitHub仓库地址: "

if "%REPO_URL%"=="" (
    echo 错误：未输入仓库地址
    pause
    exit /b 1
)

echo 添加远程仓库...
git remote add origin %REPO_URL%

echo 推送source分支...
git push -u origin source

echo.
echo 步骤 4: 创建main分支
git checkout --orphan main
git rm -rf .
echo # 加密文件存放分支 > README.md
git add README.md
git commit -m "初始化main分支"
git push -u origin main
git checkout source

echo.
echo ========================================
echo           部署完成！
echo ========================================
echo.
echo 接下来请手动完成以下设置：
echo.
echo 1. 设置密码Secret：
echo    - 访问你的仓库 Settings ^> Secrets and variables ^> Actions
echo    - 点击 "New repository secret"
echo    - Name: SITE_PASSWORD
echo    - Secret: %PASSWORD%
echo.
echo 2. 启用GitHub Pages：
echo    - 访问你的仓库 Settings ^> Pages
echo    - Source: Deploy from a branch
echo    - Branch: main
echo    - Folder: / (root)
echo.
echo 3. 等待部署完成后访问：
echo    https://zhtinist.github.io/%REPO%/
echo    密码: %PASSWORD%
echo.
echo 4. 后续使用：
echo    - 将文件放入 src 目录
echo    - 运行 quick-update.bat 推送更新
echo.
pause