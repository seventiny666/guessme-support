#!/bin/bash

echo "🔍 验证iPad首页代码修复..."
echo ""

# 检查VStack(spacing: 0)
echo "1. 检查VStack结构..."
if grep -q "VStack(spacing: 0)" GuessMe/ContentView.swift; then
    echo "   ✅ VStack(spacing: 0) - 正确"
else
    echo "   ❌ VStack(spacing: 0) - 未找到"
fi

# 检查ScrollView(showsIndicators: false)
echo "2. 检查ScrollView..."
if grep -q "ScrollView(showsIndicators: false)" GuessMe/ContentView.swift; then
    echo "   ✅ ScrollView(showsIndicators: false) - 正确"
else
    echo "   ❌ ScrollView(showsIndicators: false) - 未找到"
fi

# 检查是否有mask遮罩
echo "3. 检查mask遮罩..."
if grep -q ".mask(" GuessMe/ContentView.swift; then
    echo "   ❌ 发现mask遮罩 - 需要删除"
else
    echo "   ✅ 没有mask遮罩 - 正确"
fi

# 检查5列布局
echo "4. 检查iPad列数..."
if grep -q "count: isIPad ? 5 : 2" GuessMe/ContentView.swift; then
    echo "   ✅ iPad 5列布局 - 正确"
else
    echo "   ❌ iPad列数配置 - 未找到"
fi

# 检查底部padding
echo "5. 检查底部padding..."
if grep -q ".padding(.bottom, horizontalSizeClass == .regular ? 180 : 160)" GuessMe/ContentView.swift; then
    echo "   ✅ 底部padding - 正确"
else
    echo "   ⚠️  底部padding - 可能不同"
fi

echo ""
echo "📊 验证结果："
echo "如果所有项都是 ✅，说明代码修复正确。"
echo "如果界面仍显示旧样式，请执行以下步骤："
echo ""
echo "1. 清理缓存："
echo "   rm -rf ~/Library/Developer/Xcode/DerivedData"
echo "   rm -rf build"
echo ""
echo "2. 在Xcode中："
echo "   - Shift+Cmd+K (Clean)"
echo "   - Cmd+B (Build)"
echo "   - Cmd+R (Run)"
echo ""
echo "3. 在iPad设备上删除应用后重新安装"
echo ""
