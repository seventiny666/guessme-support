#!/bin/bash

echo "=========================================="
echo "iPad首页布局修复 - 完全清理重编译脚本"
echo "=========================================="
echo ""

# 1. 清理Xcode DerivedData
echo "🧹 步骤1: 清理Xcode DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData
echo "✅ DerivedData已清理"
echo ""

# 2. 清理项目build文件夹
echo "🧹 步骤2: 清理项目build文件夹..."
rm -rf build
echo "✅ build文件夹已清理"
echo ""

# 3. 清理模块缓存
echo "🧹 步骤3: 清理模块缓存..."
rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
echo "✅ 模块缓存已清理"
echo ""

# 4. 清理Xcode缓存
echo "🧹 步骤4: 清理Xcode缓存..."
rm -rf ~/Library/Caches/com.apple.dt.Xcode
echo "✅ Xcode缓存已清理"
echo ""

echo "=========================================="
echo "✅ 所有缓存已清理完成！"
echo "=========================================="
echo ""
echo "📱 接下来请执行以下步骤："
echo ""
echo "1. 在iPad设备上删除应用"
echo "   - 长按应用图标"
echo "   - 选择'删除App'"
echo "   - 确认删除"
echo ""
echo "2. 在Xcode中："
echo "   - 按 Shift+Cmd+K (Clean Build Folder)"
echo "   - 按 Cmd+B (Build)"
echo "   - 按 Cmd+R (Run)"
echo ""
echo "3. 验证修复效果："
echo "   ✓ 顶部显示标题'你比划我猜'"
echo "   ✓ iPad显示4列卡片"
echo "   ✓ iPhone显示2列卡片"
echo "   ✓ 底部显示两个按钮"
echo "   ✓ 底部显示'阅读隐私政策'链接"
echo ""
echo "=========================================="
