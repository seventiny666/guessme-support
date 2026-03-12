#!/bin/bash

# App Store 打包上传脚本
# 使用方法: ./build_and_upload.sh

set -e  # 遇到错误立即退出

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 配置信息
PROJECT_NAME="GuessMeIos"
SCHEME_NAME="GuessMe"
BUNDLE_ID="com.seventinygame.app"
TEAM_ID="346F2WR689"
BUILD_DIR="./build"
ARCHIVE_PATH="$BUILD_DIR/$SCHEME_NAME.xcarchive"
EXPORT_PATH="$BUILD_DIR/export"
IPA_PATH="$EXPORT_PATH/$SCHEME_NAME.ipa"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  App Store 打包上传脚本${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 1. 检查 Xcode 版本
echo -e "${YELLOW}[1/7] 检查 Xcode 版本...${NC}"
XCODE_VERSION=$(xcodebuild -version | head -n 1)
echo "当前 Xcode 版本: $XCODE_VERSION"

# 检查是否是 Xcode 16+
XCODE_MAJOR_VERSION=$(xcodebuild -version | head -n 1 | sed 's/Xcode //' | cut -d. -f1)
if [ "$XCODE_MAJOR_VERSION" -lt 16 ]; then
    echo -e "${RED}错误: 需要 Xcode 16 或更高版本${NC}"
    echo -e "${RED}当前版本: $XCODE_VERSION${NC}"
    echo -e "${YELLOW}请先升级 Xcode，参考 Xcode升级指南.md${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Xcode 版本符合要求${NC}"
echo ""

# 2. 清理旧的构建文件
echo -e "${YELLOW}[2/7] 清理旧的构建文件...${NC}"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
echo -e "${GREEN}✓ 清理完成${NC}"
echo ""

# 3. 清理 Xcode 缓存
echo -e "${YELLOW}[3/7] 清理 Xcode 缓存...${NC}"
xcodebuild clean -project "$PROJECT_NAME.xcodeproj" -scheme "$SCHEME_NAME" -configuration Release
echo -e "${GREEN}✓ 缓存清理完成${NC}"
echo ""

# 4. 构建 Archive
echo -e "${YELLOW}[4/7] 开始构建 Archive...${NC}"
echo "这可能需要几分钟时间..."
xcodebuild archive \
    -project "$PROJECT_NAME.xcodeproj" \
    -scheme "$SCHEME_NAME" \
    -configuration Release \
    -archivePath "$ARCHIVE_PATH" \
    -destination "generic/platform=iOS" \
    CODE_SIGN_STYLE=Automatic \
    DEVELOPMENT_TEAM="$TEAM_ID" \
    -allowProvisioningUpdates

if [ ! -d "$ARCHIVE_PATH" ]; then
    echo -e "${RED}错误: Archive 构建失败${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Archive 构建成功${NC}"
echo ""

# 5. 导出 IPA
echo -e "${YELLOW}[5/7] 导出 IPA 文件...${NC}"
xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist exportOptions.plist \
    -allowProvisioningUpdates

if [ ! -f "$IPA_PATH" ]; then
    echo -e "${RED}错误: IPA 导出失败${NC}"
    exit 1
fi
echo -e "${GREEN}✓ IPA 导出成功${NC}"
echo "IPA 路径: $IPA_PATH"
echo ""

# 6. 验证 IPA
echo -e "${YELLOW}[6/7] 验证 IPA 文件...${NC}"
xcrun altool --validate-app \
    -f "$IPA_PATH" \
    -t ios \
    --apiKey "YOUR_API_KEY" \
    --apiIssuer "YOUR_ISSUER_ID" \
    2>&1 || {
    echo -e "${YELLOW}注意: 自动验证需要配置 API Key${NC}"
    echo -e "${YELLOW}你可以手动在 Xcode Organizer 中验证${NC}"
}
echo ""

# 7. 上传到 App Store Connect
echo -e "${YELLOW}[7/7] 上传到 App Store Connect...${NC}"
echo -e "${YELLOW}选择上传方式:${NC}"
echo "1) 使用 API Key 自动上传（需要配置）"
echo "2) 使用 Xcode Organizer 手动上传（推荐）"
echo "3) 跳过上传"
read -p "请选择 (1/2/3): " upload_choice

case $upload_choice in
    1)
        echo "使用 API Key 上传..."
        xcrun altool --upload-app \
            -f "$IPA_PATH" \
            -t ios \
            --apiKey "YOUR_API_KEY" \
            --apiIssuer "YOUR_ISSUER_ID"
        ;;
    2)
        echo -e "${GREEN}请按以下步骤操作:${NC}"
        echo "1. 打开 Xcode"
        echo "2. 菜单: Window -> Organizer"
        echo "3. 选择刚才创建的 Archive"
        echo "4. 点击 'Distribute App'"
        echo "5. 选择 'App Store Connect'"
        echo "6. 点击 'Upload'"
        echo ""
        echo "Archive 位置: $ARCHIVE_PATH"
        open -a Xcode "$ARCHIVE_PATH"
        ;;
    3)
        echo "跳过上传"
        ;;
    *)
        echo "无效选择，跳过上传"
        ;;
esac
echo ""

# 完成
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  打包完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "构建信息:"
echo "  - Archive: $ARCHIVE_PATH"
echo "  - IPA: $IPA_PATH"
echo "  - Bundle ID: $BUNDLE_ID"
echo "  - Team ID: $TEAM_ID"
echo ""
echo -e "${YELLOW}下一步:${NC}"
echo "1. 如果选择了手动上传，请在 Xcode Organizer 中完成上传"
echo "2. 登录 App Store Connect 查看构建状态"
echo "3. 等待处理完成后提交审核"
echo ""
