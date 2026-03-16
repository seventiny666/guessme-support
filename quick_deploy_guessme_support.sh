#!/bin/bash

# 一键提交到 guessme-support 仓库脚本

set -e

echo "🚀 开始提交到 guessme-support 仓库..."
echo "=================================="

# 设置变量
REPO_URL="https://github.com/seventiny666/guessme-support.git"
TEMP_DIR="/tmp/guessme-support-$(date +%s)"
PROJECT_DIR="$(pwd)"

# 检查文件是否存在
echo "📋 检查必要文件..."
if [ ! -f "docs/index.html" ] || [ ! -f "docs/privacy.html" ] || [ ! -f "docs/terms.html" ] || [ ! -f "docs/README.md" ]; then
    echo "❌ 错误：找不到必要的文件"
    echo "请确保以下文件存在："
    echo "  - docs/index.html"
    echo "  - docs/privacy.html" 
    echo "  - docs/terms.html"
    echo "  - docs/README.md"
    exit 1
fi

echo "✅ 所有文件检查通过"

# 克隆仓库
echo "📥 克隆 guessme-support 仓库..."
git clone "$REPO_URL" "$TEMP_DIR"

if [ $? -ne 0 ]; then
    echo "❌ 克隆失败，请检查网络连接和仓库权限"
    exit 1
fi

# 进入仓库目录
cd "$TEMP_DIR"

# 清空现有文件
echo "🗑️  清空现有文件..."
find . -type f -not -path './.git/*' -delete
find . -type d -empty -not -path './.git*' -delete

# 复制新文件
echo "📋 复制英文版本文件..."
cp "$PROJECT_DIR/docs/index.html" "./index.html"
cp "$PROJECT_DIR/docs/privacy.html" "./privacy.html"
cp "$PROJECT_DIR/docs/terms.html" "./terms.html"
cp "$PROJECT_DIR/docs/README.md" "./README.md"

# 验证文件复制成功
echo "✅ 验证文件..."
for file in index.html privacy.html terms.html README.md; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ❌ $file 复制失败"
        exit 1
    fi
done

# 添加所有文件
echo "📝 添加文件到 Git..."
git add .

# 检查是否有更改
if git diff --cached --quiet; then
    echo "ℹ️  没有需要提交的更改，文件已经是最新的"
else
    # 提交更改
    echo "💾 提交更改..."
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
    echo "🚀 推送到远程仓库..."
    git push origin main || git push origin master
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "=================================="
        echo "  ✅ 提交成功！"
        echo "=================================="
        echo ""
        echo "🌐 GitHub Pages 网址（1-5分钟后生效）："
        echo "  技术支持: https://seventiny666.github.io/guessme-support/"
        echo "  隐私政策: https://seventiny666.github.io/guessme-support/privacy.html"
        echo "  使用条款: https://seventiny666.github.io/guessme-support/terms.html"
        echo ""
        echo "📋 App Store Connect 填写："
        echo "  隐私政策网址: https://seventiny666.github.io/guessme-support/privacy.html"
        echo "  技术支持网址: https://seventiny666.github.io/guessme-support/"
        echo ""
        echo "📧 联系邮箱: seventiny007@126.com"
        echo "🎮 游戏时长: 30s/60s/90s/120s"
        echo ""
        echo "⏰ 请等待 1-5 分钟后访问网址验证"
    else
        echo ""
        echo "❌ 推送失败"
        echo "请检查网络连接和 Git 配置"
        exit 1
    fi
fi

# 返回原目录
cd "$PROJECT_DIR"

# 清理临时目录
echo "🧹 清理临时文件..."
rm -rf "$TEMP_DIR"

echo ""
echo "✅ 操作完成！"