# GitHub Pages 部署指南

## 快速部署步骤

### 1. 创建GitHub仓库

1. 登录 [GitHub](https://github.com)
2. 点击右上角 "+" > "New repository"
3. 填写信息：
   - Repository name: `guessme-support`
   - Description: `你比划我猜 - 技术支持页面`
   - 选择 "Public"
   - ✅ 勾选 "Add a README file"
4. 点击 "Create repository"

### 2. 上传HTML文件

#### 方法A：通过网页上传（最简单）

1. 在仓库页面，点击 "Add file" > "Upload files"
2. 将 `index.html` 文件拖拽到页面
3. 在底部填写提交信息：`Add support page`
4. 点击 "Commit changes"

#### 方法B：通过命令行（如果你熟悉Git）

```bash
# 克隆仓库
git clone https://github.com/[你的用户名]/guessme-support.git
cd guessme-support

# 复制HTML文件到仓库
cp /path/to/index.html .

# 提交并推送
git add index.html
git commit -m "Add support page"
git push
```

### 3. 启用GitHub Pages

1. 在仓库页面，点击 "Settings"（设置）
2. 在左侧菜单找到 "Pages"
3. 在 "Source" 下拉菜单中选择：
   - Branch: `main` (或 `master`)
   - Folder: `/ (root)`
4. 点击 "Save"
5. 等待1-2分钟，页面会显示：
   ```
   Your site is published at https://[你的用户名].github.io/guessme-support/
   ```

### 4. 获取网址

你的技术支持页面网址将是：
```
https://[你的用户名].github.io/guessme-support/
```

例如，如果你的GitHub用户名是 `zhangsan`，网址就是：
```
https://zhangsan.github.io/guessme-support/
```

### 5. 填写到App Store Connect

将这个网址填写到App Store Connect的"技术支持网址"字段：
```
https://[你的用户名].github.io/guessme-support/
```

## 自定义域名（可选）

如果你有自己的域名，可以：

1. 在仓库根目录创建 `CNAME` 文件
2. 文件内容填写你的域名：`support.yourdomain.com`
3. 在域名DNS设置中添加CNAME记录指向：`[你的用户名].github.io`

## 更新页面

如果需要修改内容：

1. 在GitHub仓库中点击 `index.html`
2. 点击右上角的铅笔图标（编辑）
3. 修改内容
4. 点击 "Commit changes"
5. 等待1-2分钟，更改会自动生效

## 注意事项

- GitHub Pages 是免费的
- 页面会自动使用HTTPS
- 更新后可能需要1-2分钟才能看到变化
- 如果页面没有显示，检查仓库是否设置为Public

## 需要帮助？

如果遇到问题：
1. 确认仓库是Public（公开）
2. 确认GitHub Pages已启用
3. 等待几分钟让更改生效
4. 清除浏览器缓存后重试

## 临时方案

如果现在来不及部署，可以先在App Store Connect填写：
```
https://github.com/[你的用户名]/guessme-support
```

审核通过后再部署GitHub Pages并更新网址。
