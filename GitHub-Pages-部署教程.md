# GitHub Pages 部署教程 - 图文版

## 📦 你已经有的文件

在 `support-page` 文件夹中：
- `index.html` - 技术支持页面（已生成）
- `README.md` - 部署说明

## 🚀 5分钟快速部署

### 步骤1：创建GitHub账号（如果还没有）

1. 访问 https://github.com
2. 点击 "Sign up" 注册
3. 填写邮箱、密码、用户名
4. 验证邮箱

### 步骤2：创建新仓库

1. 登录GitHub后，点击右上角 "+" 按钮
2. 选择 "New repository"
3. 填写以下信息：
   ```
   Repository name: guessme-support
   Description: 你比划我猜技术支持页面
   选择: Public (公开)
   勾选: Add a README file
   ```
4. 点击绿色按钮 "Create repository"

### 步骤3：上传HTML文件

1. 在新创建的仓库页面，点击 "Add file" 按钮
2. 选择 "Upload files"
3. 将 `support-page/index.html` 文件拖拽到页面中
4. 在底部 "Commit changes" 区域：
   ```
   标题: Add support page
   ```
5. 点击绿色按钮 "Commit changes"

### 步骤4：启用GitHub Pages

1. 在仓库页面顶部，点击 "Settings"（齿轮图标）
2. 在左侧菜单中，向下滚动找到 "Pages"
3. 在 "Build and deployment" 部分：
   - Source: 选择 "Deploy from a branch"
   - Branch: 选择 "main" (或 "master")
   - Folder: 选择 "/ (root)"
4. 点击 "Save" 按钮
5. 页面会刷新，顶部会显示：
   ```
   ✅ Your site is live at https://[你的用户名].github.io/guessme-support/
   ```

### 步骤5：获取网址

你的技术支持页面网址：
```
https://[你的用户名].github.io/guessme-support/
```

**示例：**
- 如果你的GitHub用户名是 `zhangsan`
- 网址就是：`https://zhangsan.github.io/guessme-support/`

### 步骤6：填写到App Store Connect

1. 打开 App Store Connect
2. 找到 "技术支持网址 (URL)" 字段
3. 填写：`https://[你的用户名].github.io/guessme-support/`
4. 保存

## ✅ 完成！

现在你有了一个专业的技术支持页面，包含：
- ✅ 应用介绍
- ✅ 常见问题解答
- ✅ 订阅说明
- ✅ 联系方式
- ✅ 隐私政策
- ✅ 响应式设计（手机/平板/电脑都好看）

## 🔧 如何更新页面内容

如果以后需要修改内容：

1. 在GitHub仓库中点击 `index.html` 文件
2. 点击右上角的铅笔图标 ✏️（Edit this file）
3. 修改内容
4. 滚动到底部，点击 "Commit changes"
5. 等待1-2分钟，更改会自动生效

## ⏱️ 时间不够？临时方案

如果现在来不及部署，可以：

1. **临时填写GitHub仓库地址**：
   ```
   https://github.com/[你的用户名]/guessme-support
   ```

2. **或者使用邮箱**（不推荐）：
   ```
   mailto:784430005@qq.com
   ```

3. **审核通过后再更新**为正式的GitHub Pages网址

## 💡 提示

- GitHub Pages 完全免费
- 自动使用HTTPS（安全）
- 全球CDN加速
- 可以随时更新内容
- 不需要服务器或域名

## ❓ 常见问题

**Q: 页面显示404？**
A: 等待2-5分钟，GitHub Pages需要时间部署

**Q: 可以用自己的域名吗？**
A: 可以，但需要额外配置DNS，现在用GitHub提供的域名就够了

**Q: 页面可以修改吗？**
A: 可以随时修改，直接在GitHub上编辑HTML文件即可

**Q: 需要付费吗？**
A: 完全免费，GitHub Pages对公开仓库免费

## 📞 需要帮助？

如果遇到问题，可以：
1. 检查仓库是否设置为Public（公开）
2. 确认已启用GitHub Pages
3. 清除浏览器缓存重试
4. 等待几分钟让更改生效

---

准备好了吗？现在就去创建你的技术支持页面吧！🚀
