# lucky_dabao

加密文件共享平台。

## 使用方法

将文件放入 `src` 目录，按分类创建子文件夹，然后推送到 source 分支即可自动部署。

```
src/
├── 分类A/
│   └── 文件...
├── 分类B/
│   └── 文件...
└── 文件...
```

## 更新内容

```bash
git add .
git commit -m "更新内容"
git push origin source
```
