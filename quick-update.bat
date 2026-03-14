@echo off
chcp 65001 >nul
echo 快速更新加密网站...
echo.

REM 检查是否在正确的分支
git branch --show-current | findstr "source" >nul
if errorlevel 1 (
    echo 切换到source分支...
    git checkout source
)

echo 添加所有更改...
git add .

echo 请输入提交信息 (直接回车使用默认信息):
set /p commit_msg="提交信息: "
if "%commit_msg%"=="" set commit_msg=更新网站内容

echo 提交更改...
git commit -m "%commit_msg%"

echo 推送到GitHub...
git push origin source

echo.
echo ✅ 更新完成！
echo GitHub Actions正在自动加密并部署网站...
echo 请稍等几分钟后访问: https://zhtinist.github.io/lucky_dabao/
echo.
pause