#!/bin/bash

echo "=========================================="
echo "  推送 GitHub Pages 文件"
echo "=========================================="
echo ""

# 检查docs目录是否存在
if [ ! -d "docs" ]; then
    echo "❌ 错误：docs 目录不存在"
    exit 1
fi

# 添加文件
echo "📝 添加文件到 Git..."
git add docs/

# 检查是否有更改
if git diff --cached --quiet; then
    echo "ℹ️  没有需要提交的更改"
else
    # 提交更改
    echo "💾 提交更改..."
    git commit -m "添加 GitHub Pages 支持页面（技术支持、隐私政策、使用条款）"
    
    # 推送到 GitHub
    echo "🚀 推送到 GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "=========================================="
        echo "  ✅ 推送成功！"
        echo "=========================================="
        echo ""
        echo "🌐 访问以下URL（1-5分钟后生效）："
        echo "   技术支持: https://seventinygame.github.io/iosguessme/"
        echo "   隐私政策: https://seventinygame.github.io/iosguessme/privacy.html"
        echo "   使用条款: https://seventinygame.github.io/iosguessme/terms.html"
        echo ""
        echo "📋 请在 App Store Connect 中填写："
        echo "   隐私政策网址: https://seventinygame.github.io/iosguessme/privacy.html"
        echo "   技术支持网址: https://seventinygame.github.io/iosguessme/"
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

echo "✅ 完成！"
