# 🚀 完整部署步骤

## 当前状态
✅ 项目文件已准备完毕
✅ 文件夹名已改为 `src`（英文）
✅ 所有配置文件已更新

## 立即执行的步骤

### 1. 提交当前更改
```bash
git add .
git commit -m "完成项目配置，准备部署"
```

### 2. 创建GitHub仓库
1. 访问 https://github.com/new
2. Repository name: `lucky_dabao`
3. 设置为 **Private**
4. 不要勾选任何初始化选项
5. 点击 "Create repository"

### 3. 连接并推送
```bash
# 添加远程仓库（替换为你的实际地址）
git remote add origin https://github.com/zhtinist/lucky_dabao.git

# 推送source分支
git push -u origin source
```

### 4. 创建main分支
```bash
git checkout --orphan main
git rm -rf .
echo "# 加密文件存放分支" > README.md
git add README.md
git commit -m "初始化main分支"
git push -u origin main
git checkout source
```

### 5. 设置GitHub Secrets
1. 在仓库页面点击 **Settings**
2. 左侧菜单：**Secrets and variables** > **Actions**
3. 点击 **New repository secret**
4. Name: `SITE_PASSWORD`
5. Secret: `LuckyDabao2026`
6. 点击 **Add secret**

### 6. 启用GitHub Pages
1. 在仓库页面点击 **Settings**
2. 滚动到 **Pages** 部分
3. Source: **Deploy from a branch**
4. Branch: **main**
5. Folder: **/ (root)**
6. 点击 **Save**

## 🎉 完成！

网站地址：https://zhtinist.github.io/lucky_dabao/
访问密码：`LuckyDabao2026`

## 📁 后续使用

1. 将要加密的文件放入 `src` 目录
2. 运行：
   ```bash
   git add .
   git commit -m "添加新文件"
   git push origin source
   ```
3. GitHub Actions会自动加密并更新网站

## 🛠️ 快捷脚本

- `manual-deploy.bat` - 引导完成部署
- `quick-update.bat` - 快速推送更新

## 📋 项目结构

```
├── src/                        # 要加密的文件
│   ├── test.txt               # 测试文件
│   └── sample.html            # 示例页面
├── .github/workflows/         # 自动化部署
├── manual-deploy.bat          # 部署脚本
├── quick-update.bat          # 更新脚本
└── DEPLOY_STEPS.md           # 本文件
```

现在你可以按照上述步骤完成部署！