#!/bin/bash

# 为当前仓库设置 GitHub Pages

echo "=========================================="
echo "  设置 GitHub Pages"
echo "=========================================="
echo ""

# 检查是否在 git 仓库中
if [ ! -d .git ]; then
    echo "❌ 错误：当前目录不是 Git 仓库"
    exit 1
fi

# 创建docs目录
echo "📁 创建 docs 目录..."
mkdir -p docs

# 复制文件到docs目录
echo "📋 复制文件到 docs 目录..."
cp support-page/index.html docs/index.html
cp support-page/privacy.html docs/privacy.html

# 创建terms.html
cat > docs/terms.html << 'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>使用条款 - 你比划我猜</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 32px;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .header p {
            font-size: 16px;
            opacity: 0.9;
        }

        .content {
            padding: 40px 30px;
        }

        .update-date {
            background: #f0f4ff;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            color: #667eea;
            font-size: 14px;
            text-align: center;
        }

        .section {
            margin-bottom: 35px;
        }

        .section h2 {
            color: #667eea;
            font-size: 22px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f4ff;
        }

        .section p {
            margin-bottom: 15px;
            color: #555;
            font-size: 15px;
        }

        .section ul {
            margin-left: 20px;
            margin-bottom: 15px;
        }

        .section li {
            margin-bottom: 8px;
            color: #555;
            font-size: 15px;
        }

        .footer {
            background: #f8f9fa;
            padding: 30px;
            text-align: center;
            color: #666;
            font-size: 14px;
        }

        .footer p {
            margin-bottom: 10px;
        }

        .footer a {
            color: #667eea;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .header {
                padding: 30px 20px;
            }

            .header h1 {
                font-size: 26px;
            }

            .content {
                padding: 30px 20px;
            }

            .section h2 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 使用条款</h1>
            <p>你比划我猜 - GuessMe</p>
        </div>

        <div class="content">
            <div class="update-date">
                📅 最后更新日期：2026年2月28日
            </div>

            <div class="section">
                <h2>1. 服务条款</h2>
                <p>欢迎使用「你比划我猜」应用（以下简称"本应用"）。通过下载、安装或使用本应用，您同意受本使用条款的约束。</p>
            </div>

            <div class="section">
                <h2>2. 应用许可</h2>
                <p>我们授予您一个有限的、非独占的、不可转让的许可证，允许您在您的个人设备上使用本应用。您不得：</p>
                <ul>
                    <li>复制、修改或创建本应用的衍生作品</li>
                    <li>反向工程、反汇编或尝试获取本应用的源代码</li>
                    <li>将本应用用于任何商业目的</li>
                    <li>尝试获得对本应用的未授权访问</li>
                </ul>
            </div>

            <div class="section">
                <h2>3. 用户责任</h2>
                <p>您同意：</p>
                <ul>
                    <li>遵守所有适用的法律和法规</li>
                    <li>不使用本应用进行任何非法或有害的活动</li>
                    <li>不骚扰、威胁或伤害他人</li>
                    <li>对您在使用本应用时的行为负责</li>
                </ul>
            </div>

            <div class="section">
                <h2>4. 订阅条款</h2>
                <p>如果您选择订阅专业版：</p>
                <ul>
                    <li>订阅由 Apple 的 App Store 处理</li>
                    <li>费用将从您的 iTunes 账户扣除</li>
                    <li>订阅会在当前周期结束前自动续订</li>
                    <li>您可以随时在 iOS 设置中取消订阅</li>
                    <li>试用期内取消不会产生任何费用</li>
                </ul>
            </div>

            <div class="section">
                <h2>5. 免责声明</h2>
                <p>本应用按"现状"提供，不提供任何明示或暗示的保证。我们不保证：</p>
                <ul>
                    <li>应用将不间断或无错误地运行</li>
                    <li>应用中的任何缺陷都将被纠正</li>
                    <li>应用将与所有设备兼容</li>
                </ul>
            </div>

            <div class="section">
                <h2>6. 责任限制</h2>
                <p>在任何情况下，我们都不对因使用或无法使用本应用而产生的任何间接、附带、特殊或后果性损害负责。</p>
            </div>

            <div class="section">
                <h2>7. 知识产权</h2>
                <p>本应用中的所有内容，包括但不限于文本、图形、徽标、图像和软件，均为我们的财产或我们的内容提供商的财产，受版权和其他知识产权法保护。</p>
            </div>

            <div class="section">
                <h2>8. 条款修改</h2>
                <p>我们保留随时修改本条款的权利。任何修改将在此页面发布，并更新"最后更新日期"。继续使用本应用即表示您接受修改后的条款。</p>
            </div>

            <div class="section">
                <h2>9. 终止</h2>
                <p>如果您违反本条款，我们可能会终止或暂停您对本应用的访问权限。</p>
            </div>

            <div class="section">
                <h2>10. 管辖法律</h2>
                <p>本条款受中华人民共和国法律管辖。</p>
            </div>

            <div class="section">
                <h2>11. 联系我们</h2>
                <p>如果您对本使用条款有任何疑问，请通过以下方式联系我们：</p>
                <ul>
                    <li>邮箱：784430005@qq.com</li>
                </ul>
            </div>
        </div>

        <div class="footer">
            <p><strong>© 2026 你比划我猜. 保留所有权利。</strong></p>
            <p><a href="index.html">返回技术支持页面</a> | <a href="privacy.html">隐私政策</a></p>
        </div>
    </div>
</body>
</html>
EOF

# 创建README.md
cat > docs/README.md << 'EOF'
# GuessMe - 你比划我猜

一款简单有趣的聚会游戏应用，适合家人朋友聚会时玩耍。一人比划一人猜，考验默契，增进感情！

## 📱 应用特性

- 🎲 **10大分类** - 500+精选词汇
- 📱 **多设备支持** - iPhone & iPad
- 🔒 **隐私保护** - 完全离线运行
- 🎯 **简单易用** - 无需学习，即开即玩
- 👨‍👩‍👧‍👦 **家庭共享** - 订阅支持家庭共享

## 🎮 如何开始

1. 在主界面选择一个分类
2. 选择游戏时长（30秒/60秒/90秒）
3. 点击"开始游戏"
4. 一人看屏幕比划，另一人猜词
5. 猜对点击✓，不会点击跳过

## 💎 专业版

订阅专业版可以解锁所有功能：
- 解锁全部10个分类
- 700+精选词汇库
- 创建自定义分类
- 无广告纯净体验

## 📞 技术支持

- 📧 邮箱：784430005@qq.com
- 🌐 网站：https://seventinygame.github.io/iosguessme/

## 📄 法律文件

- [隐私政策](privacy.html)
- [使用条款](terms.html)
- [技术支持](index.html)

## 🔐 隐私承诺

- ✅ 应用完全离线运行，无需网络连接
- ✅ 不收集任何个人信息
- ✅ 不追踪用户行为
- ✅ 无广告无打扰
- ✅ 所有数据仅存储在您的设备本地
- ✅ 不与任何第三方共享数据

## 📋 订阅信息

- 前3天免费试用
- 试用期后：每年1.99美元
- 自动续订，可随时取消
- 支持家庭共享

## © 版权

© 2026 你比划我猜. 保留所有权利。
EOF

# 添加文件到Git
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
        echo "  ✅ GitHub Pages 设置成功！"
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
