# GuessMe App Store上线阻碍问题修复设计

## 概述

GuessMe iOS应用在App Store上线前存在四个关键阻碍问题，这些问题将直接导致应用无法通过审核或功能异常。本设计文档制定了系统性的修复策略，确保应用能够成功上线并为用户提供完整的功能体验。修复策略采用分层验证方法：先修复致命问题（产品ID不匹配），再统一配置问题（邮箱地址），最后完善上线准备（App Store Connect配置和功能测试）。

## 术语表

- **Bug_Condition (C)**: 触发上线阻碍问题的条件 - 当系统配置不一致或缺失关键配置时
- **Property (P)**: 期望的正确行为 - 所有配置统一且完整，功能正常运行
- **Preservation**: 现有核心功能和用户体验必须保持不变
- **ProductID**: StoreKit中用于标识订阅产品的唯一标识符，必须与App Store Connect配置完全匹配
- **StoreKit配置**: Products.storekit文件中定义的产品配置信息
- **App Store Connect**: Apple的开发者后台，用于管理应用信息、订阅产品和审核提交

## Bug详情

### Bug条件

上线阻碍问题在以下四种情况下发生：1) 订阅功能被触发时产品ID不匹配；2) 用户查看联系信息时邮箱地址不一致；3) App Store审核团队检查时配置不完整；4) 进行功能测试时发现未验证的功能缺陷。

**正式规范:**
```
FUNCTION isBugCondition(input)
  INPUT: input of type SystemConfiguration
  OUTPUT: boolean
  
  RETURN (input.storeManagerProductID != input.storeKitProductID)
         OR (input.emailAddressInconsistent == true)
         OR (input.appStoreConnectConfigIncomplete == true)
         OR (input.functionalTestingIncomplete == true)
END FUNCTION
```

### 示例

- **产品ID不匹配**: StoreManager.swift使用"com.guessme.app.yearly"，但Products.storekit使用"com.guessme.app.yearly" - 导致订阅功能完全无法工作
- **邮箱不一致**: README.md显示"784430005@qq.com"，支持页面显示"seventiny007@126.com" - 造成用户联系困惑
- **配置不完整**: App Store Connect缺少订阅产品配置和应用截图 - 无法提交审核
- **测试不完整**: 订阅功能未在真机环境完整验证 - 可能存在隐藏的功能性bug

## 期望行为

### 保持不变的行为

**不变行为:**
- 核心游戏功能（10个分类、500+词汇、时间选择、计分系统）必须继续正常运行
- UI/UX优化（iPad 4列布局、iPhone 2列布局、响应式设计、流畅动画）必须保持不变
- 隐私保护特性（完全离线运行、不收集个人信息、完整隐私政策）必须继续有效
- 已实现的订阅特性（StoreKit 2实现、3天免费试用、家庭共享支持、恢复购买功能）必须保持功能完整

**范围:**
所有不涉及产品ID配置、邮箱地址显示、App Store Connect配置和功能测试的输入都应该完全不受此修复影响。这包括：
- 游戏玩法和用户交互
- 界面布局和视觉效果
- 数据存储和隐私保护
- 现有的订阅逻辑流程

## 假设根本原因

基于bug描述分析，最可能的问题原因包括：

1. **产品ID配置不同步**: 开发过程中StoreManager.swift和Products.storekit文件使用了不同的产品ID前缀
   - StoreManager使用"com.guessme.app.*"
   - Products.storekit使用"com.guessme.app.*"（实际应为"com.seventinygame.app.*"）

2. **邮箱地址用途混淆**: 项目中同时存在两个邮箱地址但用途划分不清晰
   - 784430005@qq.com用于开发者账号管理
   - seventiny007@126.com用于用户支持联系

3. **App Store Connect配置滞后**: 订阅产品和应用信息配置未及时同步到App Store Connect后台

4. **测试流程不完整**: 缺乏系统性的真机测试和沙盒环境验证流程

## 正确性属性

Property 1: Bug条件 - 配置统一性和完整性

_对于任何_ 系统配置输入，当bug条件成立时（配置不一致或不完整），修复后的系统应当确保所有产品ID完全匹配、邮箱地址按用途正确显示、App Store Connect配置完整、功能测试全面通过。

**验证: 需求 2.1, 2.2, 2.3, 2.4**

Property 2: 保持不变 - 核心功能保护

_对于任何_ 不涉及配置修复的输入（游戏功能、UI交互、隐私保护等），修复后的系统应当产生与原始系统完全相同的结果，保持所有核心功能和用户体验不变。

**验证: 需求 3.1, 3.2, 3.3, 3.4**

## 修复实施

### 需要的更改

假设我们的根本原因分析是正确的：

**文件**: `GuessMe/StoreManager.swift`

**函数**: `ProductID枚举`

**具体更改**:
1. **产品ID统一**: 将StoreManager.swift中的所有产品ID更新为与Products.storekit一致
   - 更新ProductID枚举中的所有rawValue
   - 确保与App Store Connect中配置的产品ID完全匹配

2. **邮箱地址规范化**: 根据用途明确邮箱地址使用规则
   - 开发者相关文档保持使用784430005@qq.com
   - 用户支持相关页面统一使用seventiny007@126.com

3. **App Store Connect配置完善**: 创建完整的订阅产品配置
   - 创建所有订阅产品（周/月/年/终身）
   - 上传高质量应用截图
   - 完善应用描述和关键词

4. **功能测试体系建立**: 建立完整的测试验证流程
   - 沙盒环境订阅功能测试
   - 真机环境完整功能验证
   - 恢复购买功能测试

5. **配置文件同步验证**: 确保所有配置文件信息一致
   - 验证Products.storekit与StoreManager.swift的产品ID匹配
   - 验证App Store Connect配置与代码配置匹配

## 测试策略

### 验证方法

测试策略采用两阶段方法：首先在未修复代码上暴露反例以确认问题存在，然后验证修复后的代码能够正确工作并保持现有行为不变。

### 探索性Bug条件检查

**目标**: 在实施修复之前暴露反例以证明bug的存在。确认或反驳根本原因分析。如果反驳，需要重新假设原因。

**测试计划**: 编写测试来模拟订阅购买流程、邮箱地址显示检查、App Store Connect配置验证。在未修复的代码上运行这些测试以观察失败并理解根本原因。

**测试用例**:
1. **订阅功能测试**: 尝试购买年度订阅产品（在未修复代码上会失败）
2. **邮箱一致性测试**: 检查所有文档和页面中的邮箱地址（在未修复代码上会发现不一致）
3. **配置完整性测试**: 验证App Store Connect中的产品配置（在未修复状态下会发现缺失）
4. **功能验证测试**: 在真机环境测试所有订阅相关功能（在未修复代码上可能发现问题）

**预期反例**:
- 订阅购买失败，显示"产品未找到"或类似错误
- 可能原因：产品ID不匹配、网络配置问题、App Store Connect配置缺失

### 修复检查

**目标**: 验证对于所有bug条件成立的输入，修复后的函数产生期望的行为。

**伪代码:**
```
FOR ALL input WHERE isBugCondition(input) DO
  result := fixedSystem(input)
  ASSERT expectedBehavior(result)
END FOR
```

### 保持不变检查

**目标**: 验证对于所有bug条件不成立的输入，修复后的函数产生与原始函数相同的结果。

**伪代码:**
```
FOR ALL input WHERE NOT isBugCondition(input) DO
  ASSERT originalSystem(input) = fixedSystem(input)
END FOR
```

**测试方法**: 推荐使用基于属性的测试进行保持不变检查，因为：
- 它自动生成跨输入域的许多测试用例
- 它捕获手动单元测试可能遗漏的边缘情况
- 它为所有非bug输入提供强有力的行为不变保证

**测试计划**: 首先在未修复代码上观察游戏功能和UI交互的行为，然后编写基于属性的测试来捕获该行为。

**测试用例**:
1. **游戏功能保持不变**: 验证所有游戏分类、词汇、计分系统在修复后继续正常工作
2. **UI布局保持不变**: 验证iPad和iPhone的布局、动画效果在修复后保持一致
3. **隐私保护保持不变**: 验证离线运行、数据保护特性在修复后继续有效
4. **现有订阅逻辑保持不变**: 验证除产品ID外的所有订阅逻辑继续正常工作

### 单元测试

- 测试产品ID枚举的正确性和一致性
- 测试邮箱地址在不同上下文中的正确显示
- 测试订阅功能的各个组件（购买、恢复、验证）
- 测试边缘情况（网络错误、用户取消、产品不存在）

### 基于属性的测试

- 生成随机的订阅场景并验证产品ID匹配正确性
- 生成随机的用户交互并验证邮箱地址显示一致性
- 测试跨多种配置的游戏功能保持不变
- 验证所有非订阅相关输入在修复后继续正常工作

### 集成测试

- 测试完整的订阅购买流程（从选择到完成）
- 测试App Store Connect配置与应用的集成
- 测试真机环境下的完整功能验证
- 测试沙盒环境下的订阅和恢复功能