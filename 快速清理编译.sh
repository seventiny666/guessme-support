#!/bin/bash

echo "🧹 开始清理Xcode缓存..."

# 删除DerivedData
echo "删除DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData

# 删除项目构建文件
echo "删除项目构建文件..."
rm -rf build

echo "✅ 清理完成！"
echo ""
echo "📝 接下来请："
echo "1. 打开Xcode"
echo "2. 按 Shift+Command+K 清理构建"
echo "3. 按 Command+B 重新编译"
echo "4. 按 Command+R 运行"
echo ""
echo "如果还有问题，请在iPad设备上删除应用后重新安装。"
