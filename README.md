# 你比划我猜 (GuessMe)

一款简单有趣的聚会游戏iOS应用，适合家人朋友聚会时玩耍。

## 应用信息

- **Bundle ID**: com.seventinygame.app
- **版本**: 1.0
- **最低系统**: iOS 15.0+
- **支持设备**: iPhone, iPad
- **开发语言**: Swift, SwiftUI

## 功能特性

### 游戏功能
- 10个游戏分类，500+精选词汇
- 免费分类：随机、成语、美食
- 专业版分类：常识、流行语、动物、名著、网络用语、职业、动画角色
- 四种时间模式：30秒、60秒、90秒、120秒
- 实时计分和进度显示
- 震动反馈

### 订阅功能
- 3天免费试用
- $1.99/年自动续订
- 支持家庭共享
- 恢复购买功能

### UI/UX
- 深色模式支持
- iPad横竖屏适配
- 响应式布局
- 流畅动画效果

### 隐私保护
- 完全离线运行
- 不收集任何个人信息
- 无广告
- 无外部链接

## 项目结构

```
GuessMe/
├── GuessMeApp.swift          # 应用入口
├── ContentView.swift         # 主界面
├── GameView.swift            # 游戏界面
├── GameViewModel.swift       # 游戏逻辑
├── PurchaseView.swift        # 订阅界面
├── StoreManager.swift        # 订阅管理
├── WordLibrary.swift         # 词库
├── ColorTheme.swift          # 主题配置
├── Products.storekit         # StoreKit配置
└── Assets.xcassets/          # 资源文件
```

## 开发环境

- Xcode 14.0+
- Swift 5.0+
- iOS 15.0+ SDK

## 构建和运行

1. 克隆项目
```bash
git clone [repository-url]
cd iosguessme
```

2. 打开项目
```bash
open GuessMeIos.xcodeproj
```

3. 选择模拟器或真机设备

4. 运行项目 (⌘R)

## 订阅测试

### 模拟器测试
1. 使用 `GuessMe/Products.storekit` 配置文件
2. 在Xcode中：Editor > StoreKit Configuration File
3. 选择 Products.storekit
4. 运行应用测试订阅流程

### 真机测试
1. 在App Store Connect创建沙盒测试账号
2. 在设备上登录沙盒账号
3. 测试订阅购买流程

## 上架准备

详见 [上架最终检查报告.md](./上架最终检查报告.md)

### 关键步骤
1. 在Xcode中创建Archive
2. 验证Archive
3. 上传到App Store Connect
4. 配置订阅产品
5. 提交审核

## 技术栈

- **UI框架**: SwiftUI
- **支付**: StoreKit 2
- **状态管理**: ObservableObject, @Published
- **异步处理**: async/await
- **本地化**: 中文、英文

## 许可证

© 2026 你比划我猜. 保留所有权利。

## 联系方式

开发者账号: 784430005@qq.com
