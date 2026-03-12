#!/bin/bash

# 部署隐私政策到 GitHub Pages

echo "=========================================="
echo "  部署隐私政策页面"
echo "=========================================="
echo ""

# 检查是否在 git 仓库中
if [ ! -d .git ]; then
    echo "❌ 错误：当前目录不是 Git 仓库"
    echo "请在项目根目录运行此脚本"
    exit 1
fi

# 检查文件是否存在
if [ ! -f "support-page/privacy.html" ]; then
    echo "❌ 错误：找不到 privacy.html 文件"
    exit 1
fi

echo "📝 准备部署以下文件："
echo "   - support-page/privacy.html"
echo "   - support-page/index.html"
echo ""

# 添加文件
echo "📦 添加文件到 Git..."
git add support-page/privacy.html support-page/index.html

# 检查是否有更改
if git diff --cached --quiet; then
    echo "ℹ️  没有需要提交的更改"
    echo "文件可能已经部署"
else
    # 提交更改
    echo "💾 提交更改..."
    git commit -m "添加隐私政策页面"
    
    # 推送到 GitHub
    echo "🚀 推送到 GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "=========================================="
        echo "  ✅ 部署成功！"
        echo "=========================================="
        echo ""
        echo "🌐 隐私政策网址（1-5分钟后生效）："
        echo "   https://seventinygame.github.io/iosguessme/support-page/privacy.html"
        echo ""
        echo "📋 请在 App Store Connect 中填写："
        echo "   隐私政策网址: https://seventinygame.github.io/iosguessme/support-page/privacy.html"
        echo "   技术支持网址: https://seventinygame.github.io/iosguessme/support-page/"
        echo ""
        echo "⏰ 等待 1-5 分钟后访问网址验证"
        echo ""
    else
        echo ""
        echo "❌ 推送失败"
        echo "请检查网络连接和 Git 配置"
        exit 1
    fi
fi
