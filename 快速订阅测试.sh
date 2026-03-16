#!/bin/bash

# GuessMe 订阅功能快速测试脚本

echo "🚀 GuessMe 订阅功能测试启动"
echo "================================"

# 检查项目文件
if [ ! -f "GuessMeIos.xcodeproj/project.pbxproj" ]; then
    echo "❌ 错误：未找到 Xcode 项目文件"
    echo "请确保在项目根目录运行此脚本"
    exit 1
fi

echo "✅ 项目文件检查通过"

# 检查 StoreKit 配置
if [ ! -f "GuessMe/Products.storekit" ]; then
    echo "❌ 错误：未找到 StoreKit 配置文件"
    exit 1
fi

echo "✅ StoreKit 配置文件存在"

# 显示产品ID配置
echo ""
echo "📋 当前产品ID配置："
echo "- 周订阅：com.guessme.app.weekly"
echo "- 月订阅：com.guessme.app.monthly"
echo "- 年订阅：com.guessme.app.yearly"
echo "- 终身版：com.guessme.app.alllifetime"

echo ""
echo "🧪 开始测试..."
echo ""
echo "1. 正在打开 Xcode 项目..."

# 打开 Xcode 项目
open GuessMeIos.xcodeproj

echo "✅ Xcode 项目已打开"
echo ""
echo "📝 接下来请手动执行以下步骤："
echo ""
echo "1. 在 Xcode 中选择 Editor → StoreKit Configuration File"
echo "2. 选择 GuessMe/Products.storekit"
echo "3. 选择 iOS 模拟器（推荐 iPhone 15 Pro）"
echo "4. 按 ⌘R 运行应用"
echo "5. 点击任意锁定的分类测试订阅功能"
echo ""
echo "🔍 测试要点："
echo "- 订阅页面是否正常显示"
echo "- 产品价格是否正常加载"
echo "- 点击订阅按钮是否有错误"
echo "- 模拟购买是否可以完成"
echo ""
echo "📞 如有问题，请查看 Xcode 控制台输出并记录错误信息"