#!/bin/bash

# 快速打包脚本（简化版）
# 使用方法: ./快速打包脚本.sh

set -e

# 配置
PROJECT="GuessMeIos.xcodeproj"
SCHEME="GuessMe"
ARCHIVE_PATH="./build/GuessMe.xcarchive"

echo "🚀 开始打包..."
echo ""

# 清理
echo "📦 清理旧文件..."
rm -rf ./build
mkdir -p ./build

# 构建
echo "🔨 构建 Archive..."
xcodebuild archive \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -configuration Release \
    -archivePath "$ARCHIVE_PATH" \
    -destination "generic/platform=iOS" \
    CODE_SIGN_STYLE=Automatic \
    DEVELOPMENT_TEAM=346F2WR689 \
    -allowProvisioningUpdates

# 导出
echo "📤 导出 IPA..."
xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath ./build/export \
    -exportOptionsPlist exportOptions.plist \
    -allowProvisioningUpdates

echo ""
echo "✅ 打包完成！"
echo ""
echo "📁 文件位置:"
echo "   Archive: $ARCHIVE_PATH"
echo "   IPA: ./build/export/GuessMe.ipa"
echo ""
echo "📱 下一步:"
echo "   1. 打开 Xcode -> Window -> Organizer"
echo "   2. 选择刚才的 Archive"
echo "   3. 点击 'Distribute App' 上传到 App Store"
echo ""

# 自动打开 Organizer
open -a Xcode "$ARCHIVE_PATH"
