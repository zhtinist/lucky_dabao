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
echo 推送完成，等待 GitHub Actions 部署...
echo.

:wait_loop
timeout /t 5 /nobreak >nul
for /f "delims=" %%s in ('gh run list --workflow="部署到 GitHub Pages" --limit 1 --json status --jq ".[0].status" 2^>nul') do set RUN_STATUS=%%s
for /f "delims=" %%c in ('gh run list --workflow="部署到 GitHub Pages" --limit 1 --json conclusion --jq ".[0].conclusion" 2^>nul') do set RUN_CONCLUSION=%%c

if "%RUN_STATUS%"=="completed" (
  if "%RUN_CONCLUSION%"=="success" (
    echo ✅ 部署成功！网站已更新。
    goto done
  ) else (
    echo ❌ 部署失败，结论: %RUN_CONCLUSION%
    goto done
  )
)
echo ⏳ 部署中... 状态: %RUN_STATUS%
goto wait_loop

:done
echo.
pause
