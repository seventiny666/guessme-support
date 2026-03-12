#!/bin/bash

echo "🚀 开始快速修复..."
echo ""

# 1. 关闭Xcode
echo "1️⃣  关闭Xcode..."
killall Xcode 2>/dev/null
sleep 2

# 2. 清理DerivedData
echo "2️⃣  清理DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData
sleep 1

# 3. 清理模拟器
echo "3️⃣  清理模拟器..."
xcrun simctl erase all 2>/dev/null
sleep 1

# 4. 清理项目缓存
echo "4️⃣  清理项目缓存..."
find . -name "*.xcworkspace" -exec rm -rf {}/xcuserdata \; 2>/dev/null
find . -name "*.xcodeproj" -exec rm -rf {}/xcuserdata \; 2>/dev/null

echo ""
echo "✅ 快速修复完成！"
echo ""
echo "📝 下一步操作："
echo "1. 打开Xcode"
echo "2. 在iPad上删除应用"
echo "3. 按 ⌘+Shift+K 清理Build"
echo "4. 按 ⌘+R 重新运行"
echo ""
echo "💡 提示: 如果还有问题，请重启Mac后再试"
