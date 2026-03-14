#!/bin/bash

# 设置变量
REPO="lucky_dabao"
PASSWORD="LuckyDabao2026"
SOURCE_FOLDER="C:\\Users\\Aaron\\Desktop\\dabao\\webpage"  # 修改为你的实际路径

echo "开始设置加密网站项目..."

# 检查是否已经在 git 仓库中
if [ ! -d ".git" ]; then
    echo "初始化 Git 仓库..."
    git init
fi

# 创建并切换到 source 分支
echo "设置 source 分支..."
git checkout -b source 2>/dev/null || git checkout source

# 更新 README
echo "# $REPO 加密网站

这是一个使用 GitHub Pages 和 GitHub Actions 自动部署的加密网站。

## 功能特点

- 自动文件加密
- 密码保护访问
- GitHub Actions 自动部署
- 响应式网页设计

## 使用方法

1. 将要加密的文件放在 \`原始文件\` 目录中
2. 推送到 source 分支
3. GitHub Actions 会自动加密文件并部署到 main 分支
4. 访问 GitHub Pages 网址，输入密码查看内容

## 密码设置

默认密码：\`$PASSWORD\`

可以通过 GitHub Secrets 修改 \`SITE_PASSWORD\` 来更改密码。

## 项目结构

\`\`\`
├── .github/workflows/
│   └── encrypt-and-deploy.yml    # 自动化部署工作流
├── 原始文件/                      # 放置要加密的文件
│   ├── test.txt                  # 测试文件
│   └── sample.html               # 示例 HTML 文件
├── README.md                     # 项目说明
└── setup.sh                     # 设置脚本
\`\`\`

## 部署步骤

1. 创建 GitHub 仓库
2. 设置密码 Secret
3. 推送代码
4. 启用 GitHub Pages
5. 访问网站

详细步骤请参考 setup.sh 脚本。
" > README.md

echo "添加文件到 Git..."
git add .

# 检查是否有更改需要提交
if git diff --staged --quiet; then
    echo "没有新的更改需要提交"
else
    git commit -m "添加加密网站项目文件"
    echo "文件已提交到本地仓库"
fi

echo ""
echo "✅ 项目设置完成！"
echo ""
echo "接下来的步骤："
echo "1. 如果还没有创建 GitHub 仓库，请运行："
echo "   gh repo create zhtinist/$REPO --private --source=. --remote=origin --push"
echo ""
echo "2. 设置网站密码："
echo "   echo '$PASSWORD' | gh secret set SITE_PASSWORD --repo zhtinist/$REPO"
echo ""
echo "3. 创建 main 分支并推送："
echo "   git checkout --orphan main"
echo "   git rm -rf ."
echo "   echo '# 加密文件存放分支' > README.md"
echo "   git add README.md"
echo "   git commit -m '初始化 main 分支'"
echo "   git push -u origin main"
echo "   git checkout source"
echo "   git push origin source"
echo ""
echo "4. 启用 GitHub Pages："
echo "   gh api -X POST /repos/zhtinist/$REPO/pages -f source.branch=main -f source.path=/"
echo ""
echo "5. 访问网站："
echo "   https://zhtinist.github.io/$REPO/"
echo ""
echo "注意：如果你有现有文件要加密，请将它们复制到 '原始文件' 目录中。"