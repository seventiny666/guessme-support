# 手动清空 guessme-support 仓库指南

## 🎯 目标
删除 https://github.com/seventiny666/guessme-support.git 仓库中的所有5个文件，然后上传新的英文版本文件。

## 📋 当前仓库文件（需要删除）
根据网页显示，当前仓库包含中文内容，需要全部删除。

## 🗑️ 方法一：通过GitHub网页界面删除

### 步骤1：删除所有现有文件
1. 访问 https://github.com/seventiny666/guessme-support
2. 对于每个文件，点击文件名进入文件详情页
3. 点击右上角的垃圾桶图标（Delete this file）
4. 在底部填写提交信息："删除旧文件"
5. 点击 "Commit changes"
6. 重复此步骤删除所有文件

### 步骤2：上传新的英文文件
1. 在仓库主页点击 "Add file" → "Upload files"
2. 将以下4个文件拖拽上传：
   - `docs/index.html` → 重命名为 `index.html`
   - `docs/privacy.html` → 重命名为 `privacy.html`
   - `docs/terms.html` → 重命名为 `terms.html`
   - `docs/README.md` → 重命名为 `README.md`
3. 提交信息填写："添加英文版本支持页面"
4. 点击 "Commit changes"

## 🚀 方法二：使用提供的自动化脚本

运行以下命令：
```bash
./clean_and_update_guessme_support.sh
```

## 🌐 完成后的网址

### GitHub Pages 网址（1-5分钟后生效）
- **技术支持页面**: https://seventiny666.github.io/guessme-support/
- **隐私政策**: https://seventiny666.github.io/guessme-support/privacy.html
- **使用条款**: https://seventiny666.github.io/guessme-support/terms.html

### App Store Connect 填写
- **隐私政策网址**: `https://seventiny666.github.io/guessme-support/privacy.html`
- **技术支持网址**: `https://seventiny666.github.io/guessme-support/`

## ⚙️ 启用 GitHub Pages

如果页面无法访问，需要启用 GitHub Pages：

1. 进入仓库设置：Settings
2. 滚动到 "Pages" 部分
3. Source 选择 "Deploy from a branch"
4. Branch 选择 "main" (或 "master")
5. Folder 选择 "/ (root)"
6. 点击 "Save"

## ✅ 验证步骤

1. **检查仓库内容**：确保只有4个英文文件
2. **测试网址**：等待1-5分钟后访问上述网址
3. **检查邮箱**：确认所有页面显示 `seventiny007@126.com`
4. **检查语言**：确认所有内容都是英文

## 🔧 故障排除

### 问题：页面显示404
- 检查 GitHub Pages 是否已启用
- 确认文件名正确（index.html, privacy.html, terms.html）
- 等待5-10分钟让 GitHub Pages 生效

### 问题：页面内容是中文
- 确认上传的是 `docs/` 文件夹中的英文版本文件
- 检查文件内容是否正确

### 问题：邮箱地址错误
- 确认使用的是更新后的文件（包含 seventiny007@126.com）

## 📞 完成后
所有支持页面将显示英文内容，邮箱地址为 `seventiny007@126.com`，可以直接用于 App Store Connect 提交。