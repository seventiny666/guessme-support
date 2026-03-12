#!/bin/bash

# 清理Xcode缓存和编译产物

echo "🧹 开始清理Xcode缓存..."

# 1. 清理DerivedData
echo "清理 DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# 2. 清理Build文件夹
echo "清理 Build 文件夹..."
rm -rf ~/Library/Developer/Xcode/Archives/*

# 3. 清理模拟器缓存
echo "清理模拟器缓存..."
xcrun simctl erase all

# 4. 清理Swift编译缓存
echo "清理 Swift 编译缓存..."
rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex

# 5. 清理项目的本地缓存
echo "清理项目本地缓存..."
find . -name "*.xcworkspace" -exec rm -rf {}/xcuserdata \;
find . -name "*.xcodeproj" -exec rm -rf {}/xcuserdata \;

echo "✅ 缓存清理完成！"
echo ""
echo "📝 下一步操作："
echo "1. 关闭Xcode"
echo "2. 在iPad上删除应用"
echo "3. 重新打开Xcode"
echo "4. 重新编译并运行"
