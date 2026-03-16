# 提交到 guessme-support 仓库完整步骤

## 🎯 目标
将修复后的英文版本支持文件提交到 https://github.com/seventiny666/guessme-support.git

## 📋 准备工作
确保以下文件已准备好：
- ✅ `docs/index.html` - 英文技术支持页面
- ✅ `docs/privacy.html` - 英文隐私政策页面  
- ✅ `docs/terms.html` - 英文使用条款页面
- ✅ `docs/README.md` - 英文项目说明文档

## 🚀 方法一：自动化脚本提交（推荐）

### 步骤1：运行自动化脚本
```bash
# 在项目根目录执行
bash upload_to_guessme_support.sh
```

如果脚本执行成功，跳到"验证步骤"。如果失败，使用方法二。

## 🔧 方法二：手动终端命令提交

### 步骤1：创建临时目录并克隆仓库
```bash
# 创建临时目录
TEMP_DIR="/tmp/guessme-support-$(date +%s)"
mkdir -p "$TEMP_DIR"

# 克隆仓库
git clone https://github.com/seventiny666/guessme-support.git "$TEMP_DIR"

# 进入仓库目录
cd "$TEMP_DIR"
```

### 步骤2：清空现有文件
```bash
# 删除所有文件（保留.git目录）
find . -type f -not -path './.git/*' -delete
find . -type d -empty -not -path './.git*' -delete

# 确认清空成功
ls -la
```

### 步骤3：复制新文件
```bash
# 复制英文版本文件（请根据实际路径调整）
cp "你的项目路径/docs/index.html" "./index.html"
cp "你的项目路径/docs/privacy.html" "./privacy.html"
cp "你的项目路径/docs/terms.html" "./terms.html"
cp "你的项目路径/docs/README.md" "./README.md"

# 验证文件复制成功
ls -la
```

### 步骤4：提交更改
```bash
# 添加所有文件
git add .

# 检查状态
git status

# 提交更改
git commit -m "更新为英文版本支持页面

- 技术支持页面 (index.html)
- 隐私政策 (privacy.html)
- 使用条款 (terms.html)  
- 项目说明 (README.md)

修复内容：
- 所有内容翻译为英文
- 邮箱更新为: seventiny007@126.com
- 游戏时长增加120秒选项
- 统一页面样式和格式"

# 推送到远程仓库
git push origin main
```

### 步骤5：清理临时目录
```bash
# 返回原目录
cd -

# 删除临时目录
rm -rf "$TEMP_DIR"
```

## 🌐 方法三：一键执行脚本

创建并运行以下一键脚本：

```bash
#!/bin/bash

echo "🚀 开始提交到 guessme-support 仓库..."

# 设置变量
REPO_URL="https://github.com/seventiny666/guessme-support.git"
TEMP_DIR="/tmp/guessme-support-$(date +%s)"
PROJECT_DIR="$(pwd)"

# 检查文件是否存在
if [ ! -f "docs/index.html" ] || [ ! -f "docs/privacy.html" ] || [ ! -f "docs/terms.html" ] || [ ! -f "docs/README.md" ]; then
    echo "❌ 错误：找不到必要的文件"
    exit 1
fi

# 克隆仓库
echo "📥 克隆仓库..."
git clone "$REPO_URL" "$TEMP_DIR"
cd "$TEMP_DIR"

# 清空现有文件
echo "🗑️  清空现有文件..."
find . -type f -not -path './.git/*' -delete

# 复制新文件
echo "📋 复制新文件..."
cp "$PROJECT_DIR/docs/index.html" "./index.html"
cp "$PROJECT_DIR/docs/privacy.html" "./privacy.html"
cp "$PROJECT_DIR/docs/terms.html" "./terms.html"
cp "$PROJECT_DIR/docs/README.md" "./README.md"

# 提交更改
echo "💾 提交更改..."
git add .
git commit -m "更新为英文版本支持页面

- 技术支持页面 (index.html)
- 隐私政策 (privacy.html)
- 使用条款 (terms.html)
- 项目说明 (README.md)

修复内容：
- 所有内容翻译为英文
- 邮箱更新为: seventiny007@126.com
- 游戏时长增加120秒选项
- 统一页面样式和格式"

# 推送
echo "🚀 推送到远程仓库..."
git push origin main || git push origin master

# 清理
cd "$PROJECT_DIR"
rm -rf "$TEMP_DIR"

echo "✅ 提交完成！"
echo ""
echo "🌐 GitHub Pages 网址（1-5分钟后生效）："
echo "  技术支持: https://seventiny666.github.io/guessme-support/"
echo "  隐私政策: https://seventiny666.github.io/guessme-support/privacy.html"
echo "  使用条款: https://seventiny666.github.io/guessme-support/terms.html"
```

保存为 `quick_deploy.sh` 并执行：
```bash
chmod +x quick_deploy.sh
./quick_deploy.sh
```

## ✅ 验证步骤

### 1. 检查GitHub仓库
访问：https://github.com/seventiny666/guessme-support
确认看到4个英文文件。

### 2. 启用GitHub Pages（如果未启用）
```bash
# 或者通过网页操作：
# 1. 进入仓库设置：Settings
# 2. 滚动到 Pages 部分
# 3. Source: Deploy from a branch
# 4. Branch: main (或 master)
# 5. Folder: / (root)
# 6. 点击 Save
```

### 3. 测试网址（等待1-5分钟）
```bash
# 使用curl测试
curl -I https://seventiny666.github.io/guessme-support/
curl -I https://seventiny666.github.io/guessme-support/privacy.html
curl -I https://seventiny666.github.io/guessme-support/terms.html

# 或者直接在浏览器访问
open https://seventiny666.github.io/guessme-support/
```

## 🎉 完成后的网址

### App Store Connect 填写
- **隐私政策网址**: `https://seventiny666.github.io/guessme-support/privacy.html`
- **技术支持网址**: `https://seventiny666.github.io/guessme-support/`

### 验证要点
- ✅ 所有页面显示英文内容
- ✅ 邮箱显示：seventiny007@126.com
- ✅ 游戏时长包含：30s/60s/90s/120s
- ✅ 页面样式统一美观

## 🔧 故障排除

### 问题：git push 失败
```bash
# 检查远程分支
git branch -r

# 如果是master分支
git push origin master

# 如果需要强制推送（谨慎使用）
git push origin main --force
```

### 问题：权限不足
```bash
# 检查Git配置
git config --global user.name
git config --global user.email

# 如果需要重新配置
git config --global user.name "你的用户名"
git config --global user.email "你的邮箱"
```

### 问题：页面显示404
- 等待5-10分钟让GitHub Pages生效
- 检查GitHub Pages设置是否正确
- 确认文件名正确（index.html, privacy.html, terms.html）

---

**选择任一方法执行即可，推荐使用方法三的一键脚本最简单快捷。**