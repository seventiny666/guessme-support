#!/bin/bash

# 使用curl和GitHub API部署文件

echo "=========================================="
echo "  使用 GitHub API 部署文件"
echo "=========================================="
echo ""

# GitHub配置
REPO_OWNER="seventiny666"
REPO_NAME="guessme-support"
BRANCH="main"

# 检查是否设置了GitHub token
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ 错误: 需要设置 GITHUB_TOKEN 环境变量"
    echo ""
    echo "请按照以下步骤获取令牌:"
    echo "1. 访问 https://github.com/settings/tokens"
    echo "2. 点击 'Generate new token (classic)'"
    echo "3. 选择 'repo' 权限"
    echo "4. 复制生成的令牌"
    echo "5. 运行: export GITHUB_TOKEN='your_token_here'"
    echo "6. 重新运行此脚本"
    echo ""
    exit 1
fi

# 函数：上传文件到GitHub
upload_file() {
    local local_file="$1"
    local remote_file="$2"
    local commit_message="$3"
    
    echo "📤 上传 $remote_file..."
    
    # 检查文件是否存在
    if [ ! -f "$local_file" ]; then
        echo "❌ 文件不存在: $local_file"
        return 1
    fi
    
    # 读取文件内容并编码为base64
    local content=$(base64 -i "$local_file")
    
    # 检查文件是否已存在（获取SHA）
    local sha_response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/contents/$remote_file")
    
    local sha=$(echo "$sha_response" | grep '"sha"' | cut -d'"' -f4)
    
    # 构建JSON数据
    local json_data="{
        \"message\": \"$commit_message\",
        \"content\": \"$content\",
        \"branch\": \"$BRANCH\""
    
    if [ ! -z "$sha" ] && [ "$sha" != "null" ]; then
        json_data="$json_data,\"sha\": \"$sha\""
    fi
    
    json_data="$json_data}"
    
    # 上传文件
    local response=$(curl -s -X PUT \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$json_data" \
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/contents/$remote_file")
    
    # 检查响应
    if echo "$response" | grep -q '"sha"'; then
        echo "✅ 成功上传: $remote_file"
        return 0
    else
        echo "❌ 上传失败: $remote_file"
        echo "响应: $response"
        return 1
    fi
}

# 上传文件
success_count=0
total_files=4

echo "开始上传文件..."
echo ""

if upload_file "docs/index.html" "index.html" "添加技术支持页面"; then
    ((success_count++))
fi

if upload_file "docs/privacy.html" "privacy.html" "添加隐私政策页面"; then
    ((success_count++))
fi

if upload_file "docs/terms.html" "terms.html" "添加使用条款页面"; then
    ((success_count++))
fi

if upload_file "docs/README.md" "README.md" "添加项目说明文档"; then
    ((success_count++))
fi

echo ""
echo "=========================================="

if [ $success_count -eq $total_files ]; then
    echo "  ✅ 所有文件上传成功!"
    echo "=========================================="
    echo ""
    echo "🌐 访问以下URL验证 (1-5分钟后生效):"
    echo "   技术支持: https://$REPO_OWNER.github.io/$REPO_NAME/"
    echo "   隐私政策: https://$REPO_OWNER.github.io/$REPO_NAME/privacy.html"
    echo "   使用条款: https://$REPO_OWNER.github.io/$REPO_NAME/terms.html"
    echo ""
    echo "📋 请在 App Store Connect 中填写:"
    echo "   隐私政策网址: https://$REPO_OWNER.github.io/$REPO_NAME/privacy.html"
    echo "   技术支持网址: https://$REPO_OWNER.github.io/$REPO_NAME/"
    echo ""
    echo "⚠️  还需要手动启用 GitHub Pages:"
    echo "1. 访问 https://github.com/$REPO_OWNER/$REPO_NAME/settings/pages"
    echo "2. Source: 选择 'Deploy from a branch'"
    echo "3. Branch: 选择 'main'"
    echo "4. Folder: 选择 '/' (root)"
    echo "5. 点击 'Save'"
else
    echo "  ❌ 部分文件上传失败 ($success_count/$total_files)"
    echo "=========================================="
fi

echo ""
echo "✅ 脚本执行完成!"