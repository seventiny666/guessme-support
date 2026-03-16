# guessme-support 仓库完整内容

这个文档包含了所有需要上传到 guessme-support 仓库的文件内容。

## 文件清单

1. index.html - 技术支持页面
2. privacy.html - 隐私政策
3. terms.html - 使用条款
4. README.md - 项目说明

---

## 1. index.html 内容

请在 guessme-support 仓库中创建 `index.html` 文件，内容如下：

[见 docs/index.html 文件]

---

## 2. privacy.html 内容

请在 guessme-support 仓库中创建 `privacy.html` 文件，内容如下：

[见 docs/privacy.html 文件]

---

## 3. terms.html 内容

请在 guessme-support 仓库中创建 `terms.html` 文件，内容如下：

[见 docs/terms.html 文件]

---

## 4. README.md 内容

请在 guessme-support 仓库中创建 `README.md` 文件，内容如下：

```markdown
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
- 🌐 网站：https://seventiny666.github.io/guessme-support/

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
```

---

## 上传步骤

### 方法1：通过GitHub网页界面（推荐）

1. 访问 https://github.com/seventiny666/guessme-support
2. 点击 "Add file" → "Create new file"
3. 输入文件名（如 index.html）
4. 粘贴对应的文件内容
5. 点击 "Commit changes"
6. 重复步骤2-5上传其他文件

### 方法2：通过Git命令行

```bash
# 克隆仓库
git clone https://github.com/seventiny666/guessme-support.git
cd guessme-support

# 复制文件
cp ../iosguessme/docs/index.html .
cp ../iosguessme/docs/privacy.html .
cp ../iosguessme/docs/terms.html .
cp ../iosguessme/docs/README.md .

# 提交和推送
git add .
git commit -m "添加技术支持页面、隐私政策和使用条款"
git push origin main
```

---

## 启用 GitHub Pages

1. 进入仓库的 Settings
2. 找到 Pages 选项
3. 选择 "Deploy from a branch"
4. 选择 "main" 分支
5. 选择 "/" (root) 文件夹
6. 点击 Save

---

## 验证

等待 1-5 分钟后，访问：

- https://seventiny666.github.io/guessme-support/
- https://seventiny666.github.io/guessme-support/privacy.html
- https://seventiny666.github.io/guessme-support/terms.html

---

## App Store Connect 配置

在 App Store Connect 中填写：

**隐私政策网址**:
```
https://seventiny666.github.io/guessme-support/privacy.html
```

**技术支持网址**:
```
https://seventiny666.github.io/guessme-support/
```

---

完成！现在您的应用就有了公开的技术支持和隐私政策页面。
