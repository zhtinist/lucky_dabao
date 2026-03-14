# lucky_dabao 加密网站

这是一个使用 GitHub Pages 和 GitHub Actions 自动部署的加密网站。

## 功能特点

- 自动文件加密
- 密码保护访问
- GitHub Actions 自动部署
- 响应式网页设计

## 使用方法

1. 将要加密的文件放在 `原始文件` 目录中
2. 推送到 source 分支
3. GitHub Actions 会自动加密文件并部署到 main 分支
4. 访问 GitHub Pages 网址，输入密码查看内容

## 密码设置

默认密码：`LuckyDabao2026`

可以通过 GitHub Secrets 修改 `SITE_PASSWORD` 来更改密码。

## 项目结构

```
├── .github/workflows/
│   └── encrypt-and-deploy.yml    # 自动化部署工作流
├── 原始文件/                      # 放置要加密的文件
│   ├── test.txt                  # 测试文件
│   └── sample.html               # 示例 HTML 文件
├── README.md                     # 项目说明
├── setup.sh                     # 设置脚本
└── package.json                  # 项目配置
```

## 快速部署

运行设置脚本：
```bash
chmod +x setup.sh
./setup.sh
```

## 手动部署步骤

### 1. 设置变量
```bash
REPO="lucky_dabao"
PASSWORD="LuckyDabao2026"
SOURCE_FOLDER="C:\\Users\\Aaron\\Desktop\\dabao\\webpage"  # 修改为你的实际路径
```

### 2. 创建 GitHub 仓库
```bash
gh repo create zhtinist/$REPO --private --source=. --remote=origin --push
```

### 3. 设置密码
```bash
echo $PASSWORD | gh secret set SITE_PASSWORD --repo zhtinist/$REPO
```

### 4. 创建 main 分支
```bash
git checkout --orphan main
git rm -rf .
echo "# 加密文件存放分支" > README.md
git add README.md
git commit -m "初始化 main 分支"
git push -u origin main
git checkout source
```

### 5. 复制你的文件
```bash
mkdir -p ./原始文件
cp -r $SOURCE_FOLDER/* ./原始文件/ 2>/dev/null || :
```

### 6. 提交并推送
```bash
git add .
git commit -m "添加所有原始文件和工作流"
git push origin source
```

### 7. 开启 Pages
```bash
gh api -X POST /repos/zhtinist/$REPO/pages -f source.branch=main -f source.path=/
```

### 8. 获取网址
你的网站地址：https://zhtinist.github.io/$REPO/

## 工作原理

1. **源文件管理**：将要加密的文件放在 `原始文件` 目录
2. **自动加密**：GitHub Actions 使用 AES 加密算法加密所有文件
3. **网页部署**：生成带密码验证的访问页面
4. **安全访问**：用户输入正确密码后可以查看解密内容

## 注意事项

- 确保已安装 GitHub CLI (`gh`)
- 密码存储在 GitHub Secrets 中，安全可靠
- 加密文件存储在 main 分支，源文件在 source 分支
- 每次推送到 source 分支都会触发重新加密和部署