# 手动推送到 guessme-support 仓库指南

由于当前环境有问题，请按照以下步骤手动推送文件到您的公开仓库。

## 方法：使用GitHub网页界面直接上传

### 步骤 1: 打开您的 guessme-support 仓库
访问: https://github.com/seventiny666/guessme-support

### 步骤 2: 上传 index.html（技术支持页面）

1. 点击 "Add file" → "Create new file"
2. 文件名输入: `index.html`
3. 复制以下内容到编辑框：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="你比划我猜 - 技术支持与帮助中心">
    <title>你比划我猜 - 技术支持</title>
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
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }
        
        .content {
            padding: 40px 30px;
        }
        
        .section {
            margin-bottom: 40px;
        }
        
        .section h2 {
            color: #667eea;
            font-size: 1.8em;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #667eea;
        }
        
        .faq-item {
            background: #f8f9fa;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }
        
        .faq-item h3 {
            color: #333;
            font-size: 1.2em;
            margin-bottom: 10px;
        }
        
        .faq-item p {
            color: #666;
            line-height: 1.8;
        }
        
        .contact-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
        }
        
        .contact-box h3 {
            font-size: 1.5em;
            margin-bottom: 15px;
        }
        
        .contact-box a {
            color: white;
            text-decoration: none;
            font-size: 1.2em;
            font-weight: bold;
            display: inline-block;
            margin-top: 10px;
            padding: 12px 30px;
            background: rgba(255,255,255,0.2);
            border-radius: 25px;
            transition: all 0.3s;
        }
        
        .contact-box a:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }
        
        .footer {
            background: #f8f9fa;
            padding: 30px;
            text-align: center;
            color: #666;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }
            
            .content {
                padding: 30px 20px;
            }
            
            .section h2 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎭 你比划我猜</h1>
            <p>技术支持与帮助中心</p>
        </div>
        
        <div class="content">
            <div class="section">
                <h2>关于应用</h2>
                <p>你比划我猜是一款简单有趣的聚会游戏，适合家人朋友聚会时玩耍。一人比划一人猜，考验默契，增进感情！</p>
            </div>
            
            <div class="section">
                <h2>常见问题</h2>
                
                <div class="faq-item">
                    <h3>❓ 如何开始游戏？</h3>
                    <p>1. 在主界面选择一个分类<br>
                       2. 选择游戏时长（30秒/60秒/90秒）<br>
                       3. 点击"开始游戏"<br>
                       4. 一人看屏幕比划，另一人猜词<br>
                       5. 猜对点击✓，不会点击跳过</p>
                </div>
                
                <div class="faq-item">
                    <h3>💎 如何订阅专业版？</h3>
                    <p>1. 在主界面点击"升级到专业版"按钮<br>
                       2. 查看订阅详情<br>
                       3. 点击"开始免费试用"<br>
                       4. 前3天免费，之后每年1.99美元自动续订</p>
                </div>
                
                <div class="faq-item">
                    <h3>🔄 如何恢复购买？</h3>
                    <p>1. 打开订阅界面<br>
                       2. 点击底部"恢复购买"按钮<br>
                       3. 系统会自动检查并恢复您的订阅</p>
                </div>
            </div>
            
            <div class="section">
                <h2>联系我们</h2>
                <div class="contact-box">
                    <h3>需要帮助？</h3>
                    <p>如果您有任何问题或建议，欢迎通过邮件联系我们</p>
                    <a href="mailto:784430005@qq.com">📧 发送邮件</a>
                </div>
            </div>
            
            <div class="section">
                <h2>法律文件</h2>
                <p><a href="privacy.html" style="color: #667eea; text-decoration: none; font-weight: 500;">📄 隐私政策</a></p>
                <p><a href="terms.html" style="color: #667eea; text-decoration: none; font-weight: 500;">📋 使用条款</a></p>
            </div>
        </div>
        
        <div class="footer">
            <p><strong>你比划我猜</strong></p>
            <p>© 2026 你比划我猜. 保留所有权利。</p>
        </div>
    </div>
</body>
</html>
```

4. 点击 "Commit changes"
5. 输入提交信息: "添加技术支持页面"
6. 点击 "Commit"

### 步骤 3: 上传 privacy.html（隐私政策）

1. 点击 "Add file" → "Create new file"
2. 文件名输入: `privacy.html`
3. 复制您本地 `docs/privacy.html` 的内容
4. 点击 "Commit changes"

### 步骤 4: 上传 terms.html（使用条款）

1. 点击 "Add file" → "Create new file"
2. 文件名输入: `terms.html`
3. 复制您本地 `docs/terms.html` 的内容
4. 点击 "Commit changes"

### 步骤 5: 上传 README.md

1. 点击 "Add file" → "Create new file"
2. 文件名输入: `README.md`
3. 复制您本地 `docs/README.md` 的内容
4. 点击 "Commit changes"

### 步骤 6: 启用 GitHub Pages

1. 进入仓库的 "Settings"
2. 找到 "Pages" 选项
3. 在 "Source" 部分选择 "Deploy from a branch"
4. 选择 "main" 分支（或 "master"）
5. 选择 "/" (root) 作为文件夹
6. 点击 "Save"

### 步骤 7: 验证

等待 1-5 分钟后，访问以下URL：

- 技术支持: https://seventiny666.github.io/guessme-support/
- 隐私政策: https://seventiny666.github.io/guessme-support/privacy.html
- 使用条款: https://seventiny666.github.io/guessme-support/terms.html

## 在 App Store Connect 中填写

一旦验证成功，请在 App Store Connect 中填写：

**隐私政策网址**:
```
https://seventiny666.github.io/guessme-support/privacy.html
```

**技术支持网址**:
```
https://seventiny666.github.io/guessme-support/
```

## 完成！

现在您的应用就有了公开的技术支持和隐私政策页面，可以提交到 App Store 审核了。
