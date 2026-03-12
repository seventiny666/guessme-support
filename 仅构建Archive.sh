#!/bin/bash

# 仅构建 Archive（不导出 IPA）
# Archive 可以在升级 Xcode 16+ 后重新导出

set -e

PROJECT="GuessMeIos.xcodeproj"
SCHEME="GuessMe"
BUILD_DIR="./build"
ARCHIVE_PATH="$BUILD_DIR/GuessMe.xcarchive"

echo "=========================================="
echo "  构建 Archive"
echo "=========================================="
echo ""

echo "📦 [1/3] 清理旧文件..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
echo "✓ 完成"
echo ""

echo "🧹 [2/3] 清理项目缓存..."
xcodebuild clean -project "$PROJECT" -scheme "$SCHEME" -configuration Release > /dev/null 2>&1
echo "✓ 完成"
echo ""

echo "🔨 [3/3] 构建 Archive..."
echo "这需要几分钟，请耐心等待..."
echo ""

xcodebuild archive \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -configuration Release \
    -archivePath "$ARCHIVE_PATH" \
    -destination "generic/platform=iOS" \
    CODE_SIGN_STYLE=Automatic \
    DEVELOPMENT_TEAM=346F2WR689 \
    -allowProvisioningUpdates

if [ ! -d "$ARCHIVE_PATH" ]; then
    echo ""
    echo "❌ Archive 构建失败"
    exit 1
fi

echo ""
echo "=========================================="
echo "  ✅ Archive 构建成功！"
echo "=========================================="
echo ""
echo "📁 Archive 位置："
echo "   $ARCHIVE_PATH"
echo ""

# 显示 Archive 大小
ARCHIVE_SIZE=$(du -sh "$ARCHIVE_PATH" | cut -f1)
echo "📊 Archive 大小: $ARCHIVE_SIZE"
echo ""

echo "📝 下一步操作："
echo ""
echo "方案1：升级后重新导出（推荐）"
echo "   1. 升级到 Xcode 16+"
echo "   2. 打开 Xcode -> Window -> Organizer"
echo "   3. 选择这个 Archive"
echo "   4. 点击 'Distribute App' 导出并上传"
echo ""
echo "方案2：升级后重新构建"
echo "   1. 升级到 Xcode 16+"
echo "   2. 运行: ./快速打包脚本.sh"
echo "   3. 直接上传新的 Archive"
echo ""

echo "💡 提示："
echo "   - Archive 已保存，可以随时导出"
echo "   - 升级 Xcode 不会影响已有的 Archive"
echo "   - 建议升级后重新构建以使用最新 SDK"
echo ""
