#!/bin/bash

# Xcode 14.2 打包脚本
# 注意：生成的包无法上传到 App Store（需要 Xcode 16+）
# 但可以用于本地测试和准备

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}========================================${NC}"
echo -e "${YELLOW}  Xcode 14.2 本地打包${NC}"
echo -e "${YELLOW}========================================${NC}"
echo ""
echo -e "${RED}⚠️  警告：${NC}"
echo -e "${RED}当前 Xcode 版本无法上传到 App Store${NC}"
echo -e "${RED}需要升级到 Xcode 16+ 才能提交审核${NC}"
echo ""
echo -e "${YELLOW}此脚本仅用于：${NC}"
echo "  1. 本地测试打包流程"
echo "  2. 生成 Archive 文件"
echo "  3. 检查构建是否成功"
echo ""
read -p "是否继续？(y/n): " continue_build

if [ "$continue_build" != "y" ]; then
    echo "已取消"
    exit 0
fi

# 配置
PROJECT="GuessMeIos.xcodeproj"
SCHEME="GuessMe"
BUILD_DIR="./build"
ARCHIVE_PATH="$BUILD_DIR/GuessMe.xcarchive"
EXPORT_PATH="$BUILD_DIR/export"

echo ""
echo -e "${GREEN}[1/5] 检查 Xcode 版本...${NC}"
xcodebuild -version
echo ""

echo -e "${GREEN}[2/5] 清理旧文件...${NC}"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
echo "✓ 清理完成"
echo ""

echo -e "${GREEN}[3/5] 清理项目缓存...${NC}"
xcodebuild clean -project "$PROJECT" -scheme "$SCHEME" -configuration Release
echo "✓ 缓存清理完成"
echo ""

echo -e "${GREEN}[4/5] 构建 Archive...${NC}"
echo "这可能需要几分钟..."
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
    echo -e "${RED}✗ Archive 构建失败${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Archive 构建成功${NC}"
echo ""

echo -e "${GREEN}[5/5] 导出 IPA...${NC}"
xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist exportOptions.plist \
    -allowProvisioningUpdates

if [ ! -f "$EXPORT_PATH/GuessMe.ipa" ]; then
    echo -e "${RED}✗ IPA 导出失败${NC}"
    exit 1
fi
echo -e "${GREEN}✓ IPA 导出成功${NC}"
echo ""

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  打包完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "📁 生成的文件："
echo "   Archive: $ARCHIVE_PATH"
echo "   IPA: $EXPORT_PATH/GuessMe.ipa"
echo ""
echo -e "${YELLOW}📝 下一步：${NC}"
echo "   1. 升级到 Xcode 16+ (参考 Xcode升级指南.md)"
echo "   2. 用新版 Xcode 重新打包"
echo "   3. 上传到 App Store Connect"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "   - 当前包可用于本地测试"
echo "   - 可以安装到测试设备"
echo "   - 但无法提交到 App Store"
echo ""

# 询问是否打开 Archive
read -p "是否在 Xcode 中查看 Archive？(y/n): " open_archive
if [ "$open_archive" = "y" ]; then
    open -a Xcode "$ARCHIVE_PATH"
fi
