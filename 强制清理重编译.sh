#!/bin/bash

echo "🧹 开始强制清理和重新编译..."
echo ""

# 1. 删除DerivedData
echo "1️⃣ 删除DerivedData缓存..."
rm -rf ~/Library/Developer/Xcode/DerivedData
echo "   ✅ DerivedData已删除"

# 2. 删除项目构建文件
echo "2️⃣ 删除项目构建文件..."
rm -rf build
rm -rf .build
echo "   ✅ 构建文件已删除"

# 3. 删除模块缓存
echo "3️⃣ 删除模块缓存..."
rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
echo "   ✅ 模块缓存已删除"

# 4. 删除Xcode缓存
echo "4️⃣ 删除Xcode缓存..."
rm -rf ~/Library/Caches/com.apple.dt.Xcode
echo "   ✅ Xcode缓存已删除"

echo ""
echo "✅ 清理完成！"
echo ""
echo "📝 接下来请按以下步骤操作："
echo ""
echo "1. 在iPad设备上："
echo "   - 长按应用图标"
echo "   - 选择'删除App'"
echo "   - 确认删除"
echo ""
echo "2. 在Xcode中："
echo "   - 按 Shift+Command+K (Clean Build Folder)"
echo "   - 等待清理完成"
echo "   - 按 Command+B (Build)"
echo "   - 等待编译完成"
echo "   - 按 Command+R (Run)"
echo ""
echo "3. 如果还有问题："
echo "   - 完全退出Xcode"
echo "   - 重新打开Xcode"
echo "   - 重新编译运行"
echo ""
