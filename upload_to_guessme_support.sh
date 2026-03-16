#!/bin/bash

# 上传隐私条款和技术支持文件到 guessme-support 仓库

echo "=========================================="
echo "  上传文件到 guessme-support 仓库"
echo "=========================================="
echo ""

# 检查必要文件是否存在
if [ ! -f "docs/index.html" ] || [ ! -f "docs/privacy.html" ] || [ ! -f "docs/terms.html" ] || [ ! -f "docs/README.md" ]; then
    echo "❌ 错误：找不到必要的文件"
    echo "请确保以下文件存在："
    echo "  - docs/index.html"
    echo "  - docs/privacy.html" 
    echo "  - docs/terms.html"
    echo "  - docs/README.md"
    exit 1
fi

# 创建临时目录用于克隆仓库
TEMP_DIR="/tmp/guessme-support-upload"
REPO_URL="https://github.com/seventiny666/guessme-support.git"

echo "📦 准备上传文件..."
echo ""

# 清理旧的临时目录
if [ -d "$TEMP_DIR" ]; then
    echo "🗑️  清理旧的临时目录..."
    rm -rf "$TEMP_DIR"
fi

# 克隆仓库
echo "📥 克隆 guessme-support 仓库..."
git clone "$REPO_URL" "$TEMP_DIR"

if [ $? -ne 0 ]; then
    echo "❌ 克隆失败，请检查网络连接和仓库URL"
    exit 1
fi

# 进入临时目录
cd "$TEMP_DIR"

# 删除现有文件（保留.git目录）
echo "🗑️  清理现有文件..."
find . -type f -not -path './.git/*' -delete

# 复制新的英文文件
echo "📋 复制英文版本文件..."
cp "../docs/index.html" "./index.html"
cp "../docs/privacy.html" "./privacy.html"
cp "../docs/terms.html" "./terms.html"
cp "../docs/README.md" "./README.md"

# 验证文件是否复制成功
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

邮箱已更新为: seventiny007@126.com
所有内容已翻译为英文"
    
    # 推送到 GitHub
    echo "🚀 推送到 GitHub..."
    git push origin main || git push origin master
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "=========================================="
        echo "  ✅ 上传成功！"
        echo "=========================================="
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
        echo "⏰ 等待 1-5 分钟后访问网址验证"
        echo ""
        echo "📧 所有页面的联系邮箱: seventiny007@126.com"
        echo ""
    else
        echo ""
        echo "❌ 推送失败"
        echo "请检查网络连接和 Git 配置"
        exit 1
    fi
fi

# 返回原目录
cd - > /dev/null

# 清理临时目录
echo "🧹 清理临时文件..."
rm -rf "$TEMP_DIR"

echo "✅ 操作完成！"