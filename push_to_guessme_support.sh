#!/bin/bash

# 推送到 guessme-support 公开仓库

echo "=========================================="
echo "  推送到 guessme-support 仓库"
echo "=========================================="
echo ""

# 设置临时目录
TEMP_DIR="/tmp/guessme-support-temp"
REPO_URL="https://github.com/seventiny666/guessme-support.git"

# 清理旧的临时目录
if [ -d "$TEMP_DIR" ]; then
    echo "🗑️  清理旧的临时目录..."
    rm -rf "$TEMP_DIR"
fi

# 创建临时目录
mkdir -p "$TEMP_DIR"

echo "📋 复制文件到临时目录..."

# 复制HTML文件
cp docs/index.html "$TEMP_DIR/index.html"
cp docs/privacy.html "$TEMP_DIR/privacy.html"
cp docs/terms.html "$TEMP_DIR/terms.html"
cp docs/README.md "$TEMP_DIR/README.md"

# 创建 .gitignore
cat > "$TEMP_DIR/.gitignore" << 'EOF'
.DS_Store
*.swp
*.swo
*~
.idea/
.vscode/
EOF

# 进入临时目录
cd "$TEMP_DIR"

# 初始化git仓库
echo "🔧 初始化 Git 仓库..."
git init
git config user.name "GuessMe"
git config user.email "784430005@qq.com"

# 添加远程仓库
echo "🔗 添加远程仓库..."
git remote add origin "$REPO_URL"

# 添加所有文件
echo "📝 添加文件..."
git add .

# 提交
echo "💾 提交更改..."
git commit -m "初始化技术支持页面、隐私政策和使用条款"

# 推送到远程
echo "🚀 推送到 GitHub..."
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "  ✅ 推送成功！"
    echo "=========================================="
    echo ""
    echo "🌐 访问以下URL（1-5分钟后生效）："
    echo "   技术支持: https://seventiny666.github.io/guessme-support/"
    echo "   隐私政策: https://seventiny666.github.io/guessme-support/privacy.html"
    echo "   使用条款: https://seventiny666.github.io/guessme-support/terms.html"
    echo ""
    echo "📋 请在 App Store Connect 中填写："
    echo "   隐私政策网址: https://seventiny666.github.io/guessme-support/privacy.html"
    echo "   技术支持网址: https://seventiny666.github.io/guessme-support/"
    echo ""
    echo "⏰ 等待 1-5 分钟后访问网址验证"
    echo ""
else
    echo ""
    echo "❌ 推送失败"
    echo "请检查网络连接和仓库URL"
    exit 1
fi

# 返回原目录
cd - > /dev/null

# 清理临时目录
echo "🧹 清理临时文件..."
rm -rf "$TEMP_DIR"

echo "✅ 完成！"
