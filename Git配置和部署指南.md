# Git 配置和部署指南

## 当前状态
- ✅ 隐私政策文件已创建
- ✅ 本地 Git 提交已完成
- ❌ 需要配置 GitHub 远程仓库

## 配置步骤

### 第一步：创建 GitHub 仓库（如果还没有）

1. 访问 https://github.com
2. 登录你的账号
3. 点击右上角 "+" -> "New repository"
4. 填写信息：
   - Repository name: `iosguessme`
   - Description: 你比划我猜 iOS App
   - Public（必须是公开的才能使用 GitHub Pages）
   - 不要勾选 "Initialize this repository with a README"
5. 点击 "Create repository"

### 第二步：配置远程仓库

```bash
# 添加远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/iosguessme.git

# 或者使用 SSH（如果已配置 SSH key）
git remote add origin git@github.com:YOUR_USERNAME/iosguessme.git

# 验证远程仓库
git remote -v
```

### 第三步：推送代码

```bash
# 推送到 GitHub
git push -u origin master

# 如果提示需要登录，输入 GitHub 用户名和密码
# 或者使用 Personal Access Token
```

### 第四步：启用 GitHub Pages

1. 访问仓库页面：`https://github.com/YOUR_USERNAME/iosguessme`
2. 点击 "Settings"
3. 左侧菜单找到 "Pages"
4. Source 选择：`Deploy from a branch`
5. Branch 选择：`master` 和 `/root`
6. 点击 "Save"
7. 等待几分钟，页面会显示：
   ```
   Your site is live at https://YOUR_USERNAME.github.io/iosguessme/
   ```

## 快速配置命令

```bash
# 1. 配置远程仓库（替换用户名）
git remote add origin https://github.com/seventinygame/iosguessme.git

# 2. 推送代码
git push -u origin master

# 3. 等待 1-5 分钟后访问
# https://seventinygame.github.io/iosguessme/support-page/privacy.html
```

## 如果已经有远程仓库

```bash
# 查看当前远程仓库
git remote -v

# 如果显示错误的地址，删除并重新添加
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/iosguessme.git

# 推送
git push -u origin master
```

## 使用 Personal Access Token（推荐）

如果推送时提示密码错误，需要使用 Personal Access Token：

### 创建 Token
1. GitHub -> Settings -> Developer settings
2. Personal access tokens -> Tokens (classic)
3. Generate new token (classic)
4. 勾选 `repo` 权限
5. 生成并复制 token

### 使用 Token
```bash
# 推送时使用 token 作为密码
git push origin master
# Username: 你的GitHub用户名
# Password: 粘贴你的 Personal Access Token
```

## 验证部署

### 1. 检查 GitHub Pages 状态
访问：`https://github.com/YOUR_USERNAME/iosguessme/settings/pages`

应该看到：
```
Your site is live at https://YOUR_USERNAME.github.io/iosguessme/
```

### 2. 访问隐私政策页面
```
https://YOUR_USERNAME.github.io/iosguessme/support-page/privacy.html
```

### 3. 访问技术支持页面
```
https://YOUR_USERNAME.github.io/iosguessme/support-page/
```

## 在 App Store Connect 中填写

部署成功后，在 App Store Connect 填写：

**隐私政策网址**
```
https://YOUR_USERNAME.github.io/iosguessme/support-page/privacy.html
```

**技术支持网址**
```
https://YOUR_USERNAME.github.io/iosguessme/support-page/
```

## 常见问题

### Q: 推送失败，提示 "Permission denied"
A: 检查 GitHub 账号权限，或使用 Personal Access Token

### Q: GitHub Pages 显示 404
A: 等待 5-10 分钟，GitHub Pages 需要时间构建

### Q: 页面样式不正常
A: 检查文件路径，确保 privacy.html 在 support-page 文件夹中

### Q: 可以使用其他 Git 托管服务吗？
A: 可以，但需要支持静态页面托管（如 GitLab Pages、Gitee Pages）

## 如果你已经有 GitHub 仓库

如果你之前已经创建了仓库（比如 seventinygame/iosguessme），直接使用：

```bash
# 配置远程仓库
git remote add origin https://github.com/seventinygame/iosguessme.git

# 推送
git push -u origin master

# 隐私政策网址
https://seventinygame.github.io/iosguessme/support-page/privacy.html
```

## 手动上传方式（如果 Git 推送有问题）

1. 访问 GitHub 仓库
2. 创建 `support-page` 文件夹
3. 上传 `privacy.html` 和 `index.html`
4. 等待 GitHub Pages 构建
5. 访问网址验证

## 下一步

部署完成后：
1. ✅ 验证隐私政策页面可以访问
2. ✅ 在 App Store Connect 填写网址
3. ✅ 继续完成其他上架准备工作
4. ✅ 升级 Xcode 并重新打包
5. ✅ 提交审核
