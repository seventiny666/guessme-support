#!/bin/bash

# Xcode 14.2 自动打包脚本（无交互）
# 注意：生成的包无法上传到 App Store（需要 Xcode 16+）

set -e

# 配置
PROJECT="GuessMeIos.xcodeproj"
SCHEME="GuessMe"
BUILD_DIR="./build"
ARCHIVE_PATH="$BUILD_DIR/GuessMe.xcarchive"
EXPORT_PATH="$BUILD_DIR/export"

echo "=========================================="
echo "  开始打包 (Xcode 14.2)"
echo "=========================================="
echo ""

echo "⚠️  注意：当前版本无法上传 App Store"
echo "需要 Xcode 16+ 才能提交审核"
echo ""

echo "[1/5] 检查 Xcode 版本..."
xcodebuild -version
echo ""

echo "[2/5] 清理旧文件..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
echo "✓ 完成"
echo ""

echo "[3/5] 清理项目缓存..."
xcodebuild clean -project "$PROJECT" -scheme "$SCHEME" -configuration Release 2>&1 | grep -E "CLEAN|error|warning" || true
echo "✓ 完成"
echo ""

echo "[4/5] 构建 Archive..."
echo "这需要几分钟，请耐心等待..."
xcodebuild archive \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -configuration Release \
    -archivePath "$ARCHIVE_PATH" \
    -destination "generic/platform=iOS" \
    CODE_SIGN_STYLE=Automatic \
    DEVELOPMENT_TEAM=346F2WR689 \
    -allowProvisioningUpdates \
    2>&1 | grep -E "BUILD|ARCHIVE|error|warning|===|Signing" || true

if [ ! -d "$ARCHIVE_PATH" ]; then
    echo "✗ Archive 构建失败"
    exit 1
fi
echo "✓ Archive 构建成功"
echo ""

echo "[5/5] 导出 IPA..."
xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist exportOptions.plist \
    -allowProvisioningUpdates \
    2>&1 | grep -E "EXPORT|error|warning|===" || true

if [ ! -f "$EXPORT_PATH/GuessMe.ipa" ]; then
    echo "✗ IPA 导出失败"
    exit 1
fi
echo "✓ IPA 导出成功"
echo ""

echo "=========================================="
echo "  打包完成！"
echo "=========================================="
echo ""
echo "📁 生成的文件："
echo "   Archive: $ARCHIVE_PATH"
echo "   IPA: $EXPORT_PATH/GuessMe.ipa"
echo ""

# 显示文件大小
if [ -f "$EXPORT_PATH/GuessMe.ipa" ]; then
    IPA_SIZE=$(du -h "$EXPORT_PATH/GuessMe.ipa" | cut -f1)
    echo "   IPA 大小: $IPA_SIZE"
fi
echo ""

echo "📝 下一步："
echo "   1. 升级到 Xcode 16+"
echo "   2. 重新打包"
echo "   3. 上传到 App Store"
echo ""
