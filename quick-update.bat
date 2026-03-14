@echo off
chcp 65001 >nul
echo 加密并推送...
echo.

node encrypt-local.js
if errorlevel 1 ( echo 加密失败 & pause & exit /b 1 )

git checkout source 2>nul
git add .
set /p msg="提交信息 (回车跳过): "
if "%msg%"=="" set msg=更新内容
git commit -m "%msg%"
git push origin source
echo.
echo 推送完成，等待自动部署...
pause
