# GuessMe App Store上线阻碍问题修复 - 实施任务清单

## 任务概述

本任务清单基于bug条件方法论，系统性修复GuessMe应用的App Store上线阻碍问题。修复策略采用探索-保持-实施-验证的四阶段方法，确保问题得到彻底解决的同时保护现有功能不受影响。

## 实施任务

- [ ] 1. 编写bug条件探索测试
  - **Property 1: Bug Condition** - App Store上线阻碍问题探索
  - **关键要求**: 此测试必须在未修复代码上失败 - 失败确认bug存在
  - **不要尝试修复测试或代码当测试失败时**
  - **注意**: 此测试编码了期望行为 - 它将在实施后通过时验证修复
  - **目标**: 暴露反例证明上线阻碍问题存在
  - **范围化PBT方法**: 针对确定性bug，将属性范围限定为具体失败案例以确保可重现性
  - 测试实施细节来自设计中的Bug Condition
  - 测试断言应匹配设计中的Expected Behavior Properties
  - 在未修复代码上运行测试
  - **预期结果**: 测试失败（这是正确的 - 证明bug存在）
  - 记录发现的反例以理解根本原因
  - 当测试编写完成、运行并记录失败时标记任务完成
  - _Requirements: 1.1, 1.2, 1.3, 1.4_

- [ ] 2. 编写保持不变属性测试（在实施修复前）
  - **Property 2: Preservation** - 核心功能和用户体验保护
  - **重要**: 遵循观察优先方法论
  - 在未修复代码上观察非bug输入的行为
  - 编写基于属性的测试捕获来自Preservation Requirements的观察行为模式
  - 基于属性的测试生成许多测试用例以提供更强保证
  - 在未修复代码上运行测试
  - **预期结果**: 测试通过（这确认了要保持的基线行为）
  - 当测试编写完成、在未修复代码上运行并通过时标记任务完成
  - _Requirements: 3.1, 3.2, 3.3, 3.4_

- [ ] 3. GuessMe App Store上线阻碍问题修复

  - [ ] 3.1 修复产品ID不匹配问题
    - 检查并统一StoreManager.swift中的ProductID枚举
    - 验证Products.storekit文件中的产品ID配置
    - 确保所有产品ID使用正确的前缀（com.seventinygame.app.*）
    - 更新年度订阅产品ID为"com.seventinygame.app.yearly"
    - 更新月度订阅产品ID为"com.seventinygame.app.monthly"
    - 更新周度订阅产品ID为"com.seventinygame.app.weekly"
    - 更新终身订阅产品ID为"com.seventinygame.app.lifetime"
    - _Bug_Condition: isBugCondition(input) where input.storeManagerProductID != input.storeKitProductID_
    - _Expected_Behavior: expectedBehavior(result) from design - 所有产品ID完全匹配_
    - _Preservation: Preservation Requirements from design - 保持现有订阅逻辑和功能_
    - _Requirements: 1.1, 2.1_

  - [ ] 3.2 统一邮箱地址配置
    - 审查所有文档和代码中的邮箱地址使用
    - 根据用途规范化邮箱地址：
      - 开发者相关文档使用784430005@qq.com
      - 用户支持相关页面使用seventiny007@126.com
    - 更新README.md中的联系邮箱
    - 更新隐私政策和服务条款中的联系邮箱
    - 更新应用内支持页面的联系邮箱
    - _Bug_Condition: isBugCondition(input) where input.emailAddressInconsistent == true_
    - _Expected_Behavior: expectedBehavior(result) from design - 邮箱地址按用途正确显示_
    - _Preservation: Preservation Requirements from design - 保持现有联系方式功能_
    - _Requirements: 1.2, 2.2_

  - [ ] 3.3 完善App Store Connect配置
    - 创建所有订阅产品配置：
      - 周度订阅（com.seventinygame.app.weekly）- 3天免费试用
      - 月度订阅（com.seventinygame.app.monthly）- 3天免费试用
      - 年度订阅（com.seventinygame.app.yearly）- 3天免费试用
      - 终身订阅（com.seventinygame.app.lifetime）- 无试用
    - 配置订阅组和家庭共享设置
    - 上传高质量应用截图（iPhone和iPad）
    - 完善应用描述、关键词和分类
    - 设置应用图标和预览视频（如需要）
    - _Bug_Condition: isBugCondition(input) where input.appStoreConnectConfigIncomplete == true_
    - _Expected_Behavior: expectedBehavior(result) from design - App Store Connect配置完整_
    - _Preservation: Preservation Requirements from design - 保持现有应用信息和功能_
    - _Requirements: 1.3, 2.3_

  - [ ] 3.4 建立完整功能测试体系
    - 设置沙盒测试环境
    - 创建测试用户账号
    - 验证所有订阅产品的购买流程
    - 测试免费试用期功能
    - 测试订阅恢复功能
    - 测试家庭共享功能
    - 进行真机环境完整功能验证
    - 测试网络异常和边缘情况处理
    - _Bug_Condition: isBugCondition(input) where input.functionalTestingIncomplete == true_
    - _Expected_Behavior: expectedBehavior(result) from design - 功能测试全面通过_
    - _Preservation: Preservation Requirements from design - 保持现有功能稳定性_
    - _Requirements: 1.4, 2.4_

  - [ ] 3.5 验证bug条件探索测试现在通过
    - **Property 1: Expected Behavior** - App Store上线阻碍问题解决验证
    - **重要**: 重新运行步骤1中的相同测试 - 不要编写新测试
    - 步骤1中的测试编码了期望行为
    - 当此测试通过时，它确认期望行为得到满足
    - 运行步骤1中的bug条件探索测试
    - **预期结果**: 测试通过（确认bug已修复）
    - _Requirements: Expected Behavior Properties from design_

  - [ ] 3.6 验证保持不变测试仍然通过
    - **Property 2: Preservation** - 核心功能和用户体验保护验证
    - **重要**: 重新运行步骤2中的相同测试 - 不要编写新测试
    - 运行步骤2中的保持不变属性测试
    - **预期结果**: 测试通过（确认无回归）
    - 确认修复后所有测试仍然通过（无回归）

- [ ] 4. 检查点 - 确保所有测试通过
  - 确保所有测试通过，如有问题请询问用户。

## 测试详细说明

### Bug条件探索测试详情

**测试目标**: 验证以下bug条件在修复前确实存在：
1. 产品ID不匹配导致订阅功能失败
2. 邮箱地址不一致造成用户困惑
3. App Store Connect配置不完整阻碍审核
4. 功能测试不完整存在隐藏问题

**测试方法**:
- 模拟订阅购买流程，验证产品ID匹配性
- 检查所有文档和页面中的邮箱地址一致性
- 验证App Store Connect中的配置完整性
- 进行真机环境功能测试验证

### 保持不变测试详情

**测试目标**: 确保以下核心功能在修复后保持不变：
1. 游戏核心功能（10个分类、500+词汇、计分系统）
2. UI/UX优化（iPad/iPhone布局、响应式设计）
3. 隐私保护特性（离线运行、数据保护）
4. 现有订阅特性（StoreKit 2、免费试用、家庭共享）

**测试方法**:
- 基于属性的测试生成随机游戏场景
- 验证UI布局在不同设备上的一致性
- 确认隐私保护功能继续有效
- 验证现有订阅逻辑保持完整

## 成功标准

修复完成后，系统应满足以下标准：
1. 所有产品ID在StoreManager.swift、Products.storekit和App Store Connect中完全匹配
2. 邮箱地址根据用途正确显示，无不一致情况
3. App Store Connect配置完整，满足审核要求
4. 所有功能通过完整测试验证，无隐藏问题
5. 核心游戏功能、UI/UX和隐私保护特性保持不变
6. 现有订阅功能继续正常工作