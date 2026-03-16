# 启用 GitHub Pages 完整指南

## 问题诊断

当前显示 "404 There isn't a GitHub Pages site here" 说明 GitHub Pages 还没有被启用。

## 解决方案

### 方法一：通过GitHub网页界面启用（推荐）

1. **打开仓库设置**
   - 访问: https://github.com/seventiny666/iosguessme
   - 点击 "Settings" 标签（在仓库名称下方）

2. **找到 Pages 设置**
   - 在左侧菜单中找到 "Pages"（可能在 "Code and automation" 部分）
   - 点击 "Pages"

3. **配置 GitHub Pages**
   - 在 "Source" 部分，选择分支
   - 选择 "master" 分支
   - 选择 "/docs" 文件夹作为根目录
   - 点击 "Save"

4. **等待部署**
   - GitHub 会自动部署您的页面
   - 通常需要 1-5 分钟
   - 您会看到一个绿色的提示，显示您的网站已发布

5. **验证**
   - 访问: https://seventinygame.github.io/iosguessme/
   - 应该能看到技术支持页面

### 方法二：通过命令行检查

如果您想通过命令行验证文件是否正确推送：

```bash
# 检查远程仓库中的docs文件夹
git ls-remote origin | grep docs

# 查看最新提交
git log --oneline -5

# 检查docs文件夹中的文件
git ls-tree -r HEAD docs/
```

### 方法三：使用 main 分支（如果需要）

如果您的仓库使用 `main` 分支而不是 `master`：

1. 首先检查是否有 `main` 分支：
   ```bash
   git branch -a
   ```

2. 如果只有 `master`，可以创建 `main` 分支：
   ```bash
   git branch -M main
   git push -u origin main
   ```

3. 然后在 GitHub Pages 设置中选择 `main` 分支

## 完整的启用步骤（图文指南）

### 步骤 1: 打开仓库
```
https://github.com/seventiny666/iosguessme
```

### 步骤 2: 点击 Settings
![Settings位置]
在仓库页面顶部，找到 "Settings" 标签

### 步骤 3: 找到 Pages
在左侧菜单中向下滚动，找到 "Pages"

### 步骤 4: 配置源
- Source: 选择 "Deploy from a branch"
- Branch: 选择 "master"
- Folder: 选择 "/docs"
- 点击 "Save"

### 步骤 5: 等待部署
GitHub 会显示一个蓝色的进度条，表示正在部署

### 步骤 6: 验证
当看到绿色的提示 "Your site is live at https://seventinygame.github.io/iosguessme/" 时，表示部署成功

## 常见问题

### Q: 为什么还是显示 404？
A: 
1. 确保已经点击了 "Save" 按钮
2. 等待 5-10 分钟让 GitHub 完成部署
3. 清除浏览器缓存（Ctrl+Shift+Delete 或 Cmd+Shift+Delete）
4. 尝试在隐私浏览模式下访问

### Q: 我应该选择哪个分支？
A: 选择您推送 docs 文件夹的分支。在这个案例中是 "master"

### Q: 我应该选择哪个文件夹？
A: 选择 "/docs"，因为我们在 docs 文件夹中创建了 HTML 文件

### Q: 如何更新页面内容？
A: 
1. 修改 docs 文件夹中的 HTML 文件
2. 提交更改: `git add docs/` 和 `git commit -m "更新页面"`
3. 推送: `git push origin master`
4. GitHub 会自动重新部署（通常需要 1-2 分钟）

## 验证清单

- [ ] 已访问 GitHub 仓库设置
- [ ] 已找到 Pages 选项
- [ ] 已选择 master 分支
- [ ] 已选择 /docs 文件夹
- [ ] 已点击 Save
- [ ] 已等待 5-10 分钟
- [ ] 已清除浏览器缓存
- [ ] 已验证 https://seventinygame.github.io/iosguessme/ 可访问

## 如果仍然不工作

1. **检查文件是否存在**
   ```bash
   git ls-tree -r HEAD docs/
   ```
   应该显示：
   ```
   100644 blob xxx	docs/index.html
   100644 blob xxx	docs/privacy.html
   100644 blob xxx	docs/terms.html
   100644 blob xxx	docs/README.md
   ```

2. **检查最新提交**
   ```bash
   git log --oneline -1
   ```

3. **强制推送（如果需要）**
   ```bash
   git push -f origin master
   ```

4. **联系 GitHub 支持**
   如果以上都不工作，可以在 GitHub 上提交 issue

## 预期结果

启用成功后，您应该能够访问：

- 技术支持: https://seventinygame.github.io/iosguessme/
- 隐私政策: https://seventinygame.github.io/iosguessme/privacy.html
- 使用条款: https://seventinygame.github.io/iosguessme/terms.html

## 下一步

1. 按照上述步骤启用 GitHub Pages
2. 等待部署完成
3. 验证页面可访问
4. 在 App Store Connect 中填写 URL
5. 提交应用审核

---

**重要**: GitHub Pages 的启用需要在 GitHub 网页界面中进行，不能通过命令行完成。
