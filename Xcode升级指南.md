# Xcode 升级指南 - 解决 SDK 版本问题

## 问题描述
```
SDK version issue. This app was built with the iOS 16.2 SDK. 
All iOS and iPadOS apps must be built with the iOS 18 SDK or later, 
included in Xcode 16 or later.
```

## 当前状态
- 当前 Xcode 版本：14.2
- 当前 iOS SDK：16.2
- 需要 Xcode 版本：16+ 
- 需要 iOS SDK：18+

## 升级步骤

### 第一步：升级 Xcode

#### 方法1：通过 App Store（推荐）
1. 打开 Mac App Store
2. 搜索 "Xcode"
3. 点击"更新"或"获取"按钮
4. 等待下载完成（约 10-15 GB，需要时间）
5. 安装完成后重启 Mac

#### 方法2：从 Apple Developer 下载
1. 访问：https://developer.apple.com/download/
2. 登录你的 Apple ID
3. 下载 Xcode 16 或更高版本
4. 解压并拖到 Applications 文件夹
5. 运行命令：
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app
   sudo xcodebuild -license accept
   ```

### 第二步：验证 Xcode 版本
```bash
xcodebuild -version
```
应该显示：Xcode 16.0 或更高

### 第三步：打开项目并更新设置

1. 用新版 Xcode 打开项目：
   ```bash
   open GuessMeIos.xcodeproj
   ```

2. Xcode 会提示更新项目设置，点击"Recommended Settings"

3. 手动检查以下设置：
   - 点击项目名称（蓝色图标）
   - 选择 "GuessMeIos" target
   - 在 "General" 标签页：
     - Minimum Deployments: 保持 iOS 15.0（兼容性好）
   - 在 "Build Settings" 标签页：
     - 搜索 "iOS Deployment Target"
     - 确认是 15.0 或更高
     - 搜索 "Base SDK"
     - 应该自动设置为 "iOS 18.0" 或更高

### 第四步：清理并重新构建

```bash
# 清理构建缓存
cd /path/to/your/project
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# 在 Xcode 中：
# Product -> Clean Build Folder (Shift + Cmd + K)
# Product -> Build (Cmd + B)
```

### 第五步：创建新的 Archive

1. 在 Xcode 中：
   - Product -> Archive
2. 等待构建完成
3. 在 Organizer 中选择新的 archive
4. 点击 "Distribute App"
5. 选择 "App Store Connect"
6. 上传到 App Store Connect

## 注意事项

### 系统要求
- macOS 14.5 (Sonoma) 或更高版本才能运行 Xcode 16
- 如果你的 macOS 版本太旧，需要先升级 macOS

### 检查 macOS 版本
```bash
sw_vers
```

### 如果 macOS 版本不够
1. 打开"系统设置"
2. 点击"通用" -> "软件更新"
3. 升级到 macOS Sonoma 14.5 或更高

### 兼容性说明
- 最低部署目标保持 iOS 15.0 是合理的
- 这样可以覆盖 95%+ 的 iOS 设备
- 使用 iOS 18 SDK 构建不影响在 iOS 15 设备上运行

## 常见问题

### Q: 升级后代码会有问题吗？
A: 不会。你的代码使用的是 SwiftUI 和标准 API，完全兼容。

### Q: 需要修改代码吗？
A: 不需要。只需要用新版 Xcode 重新构建即可。

### Q: 下载 Xcode 需要多久？
A: 取决于网速，通常 30分钟 - 2小时。

### Q: 可以同时保留旧版 Xcode 吗？
A: 可以，但建议只保留一个版本以避免混淆。

## 快速命令参考

```bash
# 检查 Xcode 版本
xcodebuild -version

# 检查 macOS 版本
sw_vers

# 切换 Xcode 版本（如果有多个）
sudo xcode-select --switch /Applications/Xcode.app

# 清理构建缓存
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# 命令行构建（可选）
xcodebuild clean -project GuessMeIos.xcodeproj -scheme GuessMe
xcodebuild archive -project GuessMeIos.xcodeproj -scheme GuessMe -archivePath ./build/GuessMe.xcarchive
```

## 升级后的验证清单

- [ ] Xcode 版本 >= 16.0
- [ ] 项目可以正常打开
- [ ] 项目可以成功构建（Cmd + B）
- [ ] 可以在模拟器中运行
- [ ] 可以创建 Archive
- [ ] Archive 可以上传到 App Store Connect
- [ ] 没有新的警告或错误

## 时间线提醒

- **现在**：必须使用 iOS 18 SDK (Xcode 16+)
- **2026年4月28日起**：必须使用 iOS 26 SDK (Xcode 26+)

建议每年跟随 Apple 的 Xcode 更新节奏升级。
