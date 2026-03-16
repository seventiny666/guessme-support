#!/bin/bash

# 清空并更新 guessme-support 仓库脚本
# 删除仓库中的所有文件，然后上传新的英文版本文件

set -e

echo "🧹 清空并更新 guessme-support 仓库"
echo "=================================="

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

# 创建临时目录
TEMP_DIR=$(mktemp -d)
echo "📁 创建临时目录: $TEMP_DIR"

# 克隆仓库
echo "📥 克隆 guessme-support 仓库..."
git clone https://github.com/seventiny666/guessme-support.git "$TEMP_DIR"

# 进入仓库目录
cd "$TEMP_DIR"

# 删除所有文件（保留.git目录）
echo "🗑️  删除仓库中的所有文件..."
find . -type f -not -path './.git/*' -delete
find . -type d -empty -not -path './.git*' -delete

# 复制新文件
echo "📋 复制新的英文版本文件..."
cp "../docs/index.html" "./index.html"
cp "../docs/privacy.html" "./privacy.html"
cp "../docs/terms.html" "./terms.html"
cp "../docs/README.md" "./README.md"

# 检查文件是否复制成功
echo "✅ 验证文件..."
for file in index.html privacy.html terms.html README.md; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ❌ $file 复制失败"
        exit 1
    fi
done

# 添加所有文件到Git
echo "📦 添加文件到Git..."
git add .

# 检查是否有更改
if git diff --staged --quiet; then
    echo "ℹ️  没有检测到更改，仓库已经是最新的"
else
    # 提交更改
    echo "💾 提交更改..."
    git commit -m "清空仓库并更新为英文版本支持页面

- 删除所有旧的中文文件
- 添加英文版本的技术支持页面
- 添加英文版本的隐私政策
- 添加英文版本的使用条款
- 添加英文版本的项目说明

邮箱已更新为: seventiny007@126.com"

    # 推送到远程仓库
    echo "🚀 推送到远程仓库..."
    git push origin main || git push origin master

    echo ""
    echo "🎉 成功！仓库已清空并更新为英文版本"
    echo ""
    echo "🌐 新的网址（1-5分钟后生效）："
    echo "  技术支持: https://seventiny666.github.io/guessme-support/"
    echo "  隐私政策: https://seventiny666.github.io/guessme-support/privacy.html"
    echo "  使用条款: https://seventiny666.github.io/guessme-support/terms.html"
    echo ""
    echo "📋 App Store Connect 填写："
    echo "  隐私政策网址: https://seventiny666.github.io/guessme-support/privacy.html"
    echo "  技术支持网址: https://seventiny666.github.io/guessme-support/"
fi

# 清理临时目录
echo "🧹 清理临时目录..."
cd ..
rm -rf "$TEMP_DIR"

echo ""
echo "✅ 操作完成！"