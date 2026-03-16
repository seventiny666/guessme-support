# ContentView.swift 完整分析报告

## 文件概览
- **总行数**: 2497行
- **主要语言**: Swift (SwiftUI)
- **最后修改**: 最近进行了多项优化和调整

## 主要组件结构

### 1. 工具类和辅助组件 (行 1-255)
- **CustomTextEditor** (行 5-38): UIViewRepresentable包装器，移除白色背景
- **GameRulesView** (行 40-99): 游戏规则弹窗，支持多语言
- **ToastView** (行 101-116): Toast提示组件
- **GameExitConfirmView** (行 118-182): 游戏退出确认弹窗
- **GameOverView** (行 184-254): 游戏结束弹窗

### 2. 主视图 - ContentView (行 256-640)
**状态变量**:
- `storeManager`: 应用内购买管理
- `categoryManager`: 自定义分类管理
- `toastManager`: Toast提示管理
- `languageManager`: 多语言管理
- 多个@State变量用于UI状态控制

**主要属性**:
- `iPadLayout`: iPad专用布局 (行 316-365)
- `iPhoneLayout`: iPhone专用布局 (行 367-407)
- `topHeader`: 顶部标题栏 (行 409-449)
- `bottomButtons`: 底部按钮组件 (行 451-522)
- `navigationLinks`: 导航链接 (行 524-565)
- `overlayContent`: 覆盖层内容 (行 567-639)

### 3. 卡片组件 (行 641-765)
- **CategoryCard** (行 641-689): 系统自带分类卡片
  - 支持锁定状态显示
  - 响应式设计（iPad/iPhone）
  - 蓝色边框 `Color(red: 0.0, green: 0.21, blue: 0.55)`
  - 高度: iPad 170px, iPhone 140px

- **CustomCategoryCard** (行 691-765): 用户创建的分类卡片
  - 浅蓝色边框 `Color(red: 0.7, green: 0.8, blue: 0.95)`
  - 高度: iPad 170px, iPhone 140px (与系统卡片一致)
  - 支持编辑和删除功能
  - 移除了offset偏移，与系统卡片完全对齐

### 4. 时间选择视图 (行 767-843)
- **TimeSelectionView**: 系统分类的时间选择
- 支持多语言
- 响应式设计

### 5. 卡片网格视图 (行 845-932)
- **CardGridView**: 分离的复杂逻辑组件
- `iPadCardGrid`: iPad网格布局
- `iPhoneCardGrid`: iPhone网格布局
- `cardContent`: 卡片内容

### 6. 隐私政策视图 (行 939-1070)
- **PrivacyPolicyView**: 完整的隐私政策页面
- 多语言支持
- 响应式设计

### 7. 自定义分类视图 (行 1072-1486)
- **CustomCategoryView**: 创建新分类的界面
- iPad和iPhone不同的布局
- 图标选择功能
- 词汇输入验证

### 8. 编辑自定义分类视图 (行 1488-1657)
- **EditCustomCategoryView**: 编辑已创建分类
- iPad全屏布局
- iPhone弹窗布局
- 保存和删除功能

### 9. 自定义时间选择视图 (行 1659-1746)
- **CustomTimeSelectionView**: 自定义分类的时间选择

### 10. 自定义游戏视图 (行 1748-2008)
- **CustomGameView**: 自定义分类的游戏界面
- 复用GameView的逻辑
- 完整的游戏流程

### 11. 语言选择器视图 (行 2010-2104)
- **LanguageSelectorView**: 多语言选择界面
- 支持6种语言
- 当前语言高亮显示

### 12. 订阅视图 - PurchaseView (行 2106-2471)
**背景设置** (最新修改):
- 使用vipbg.jpg作为背景图片
- 添加半透明黑色遮罩 `Color.black.opacity(0.3)`
- 移除了关闭按钮下的深蓝紫色渐变

**标题部分** (最新修改):
- 添加了皇冠图标 `crown.fill`
- 金色渐变效果
- 阴影效果增强视觉

**定价卡片**:
- 垂直padding: 12px (从16px减少4px)
- 支持4种订阅方案: Weekly, Monthly, Yearly, Lifetime
- 选中状态显示橙色边框

**主要方法**:
- `titleSection`: 标题部分（包含皇冠图标）
- `pricingSection`: 定价方案列表
- `pricingCard()`: 单个定价卡片
- `benefitsSection`: 功能列表
- `benefitRow()`: 单个功能行
- `subscribeButton`: 订阅按钮
- `termsSection`: 条款部分
- `purchaseSelectedPlan()`: 购买逻辑
- `restorePurchases()`: 恢复购买
- `getSelectedProductID()`: 获取选中的产品ID

### 13. 游戏操作按钮 (行 2473-2497)
- **GameActionButton**: 游戏中的操作按钮

## 最近的主要修改

### 1. 游戏规则对话框 (Task 7)
- 添加了 `.lineSpacing()` 修饰符
- iPad: 13.5px (27px × 0.5)
- iPhone: 8px (16px × 0.5)

### 2. 手机端卡片高度对齐
- CustomCategoryCard高度从134px改为140px
- 添加了垂直padding `.padding(.vertical, 15)`
- 移除了offset偏移，完全对齐

### 3. 订阅界面背景
- 替换为vipbg.jpg背景图片
- 添加半透明黑色遮罩确保文字可读性
- 移除关闭按钮下的渐变背景

### 4. 订阅界面标题
- 添加皇冠图标 (crown.fill)
- 金色渐变效果
- 调整间距为20px (iPad) / 16px (iPhone)

### 5. 定价卡片高度
- 垂直padding从16px减少到12px (-4px)

### 6. 多语言文本更新
- "Choose Your Plan" → "Unlock All Features"
- 所有6种语言都已更新

### 7. 默认语言设置
- 改为英语 (en) 作为默认语言
- LocalizedStrings fallback改为英语
- 添加了resetToDefaultLanguage()方法

## 响应式设计特点

### iPad布局 (horizontalSizeClass == .regular)
- 卡片高度: 170px
- 字体更大
- 更宽的padding
- 全屏覆盖设计

### iPhone布局 (horizontalSizeClass != .regular)
- 卡片高度: 140px
- 字体较小
- 较小的padding
- 弹窗设计

## 多语言支持
- 英语 (English)
- 简体中文 (Simplified Chinese)
- 繁体中文 (Traditional Chinese)
- 日语 (Japanese)
- 韩语 (Korean)
- 西班牙语 (Spanish)

## 关键特性
1. ✅ 完整的游戏流程
2. ✅ 自定义分类创建和编辑
3. ✅ 应用内购买集成
4. ✅ 多语言支持
5. ✅ 响应式设计 (iPad/iPhone)
6. ✅ 深色/浅色主题支持
7. ✅ Toast提示系统
8. ✅ 隐私政策集成
9. ✅ 语言选择器
10. ✅ 游戏规则说明

## 代码质量
- 组件化设计，逻辑清晰
- 充分的注释说明
- 响应式设计完善
- 多语言支持完整
- 状态管理规范
