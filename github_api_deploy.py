#!/usr/bin/env python3
"""
使用GitHub API部署文件到guessme-support仓库
"""

import requests
import base64
import json
import os

# GitHub配置
GITHUB_TOKEN = ""  # 需要用户提供
REPO_OWNER = "seventiny666"
REPO_NAME = "guessme-support"
BRANCH = "main"

def read_file_content(file_path):
    """读取文件内容"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        print(f"读取文件 {file_path} 失败: {e}")
        return None

def create_or_update_file(file_path, content, commit_message):
    """使用GitHub API创建或更新文件"""
    if not GITHUB_TOKEN:
        print("错误: 需要GitHub访问令牌")
        return False
    
    # 编码内容为base64
    content_encoded = base64.b64encode(content.encode('utf-8')).decode('utf-8')
    
    # GitHub API URL
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/contents/{file_path}"
    
    # 请求头
    headers = {
        "Authorization": f"token {GITHUB_TOKEN}",
        "Accept": "application/vnd.github.v3+json",
        "Content-Type": "application/json"
    }
    
    # 检查文件是否已存在
    response = requests.get(url, headers=headers)
    sha = None
    if response.status_code == 200:
        sha = response.json().get('sha')
    
    # 请求体
    data = {
        "message": commit_message,
        "content": content_encoded,
        "branch": BRANCH
    }
    
    if sha:
        data["sha"] = sha
    
    # 发送请求
    response = requests.put(url, headers=headers, data=json.dumps(data))
    
    if response.status_code in [200, 201]:
        print(f"✅ 成功上传: {file_path}")
        return True
    else:
        print(f"❌ 上传失败: {file_path}")
        print(f"状态码: {response.status_code}")
        print(f"响应: {response.text}")
        return False

def main():
    """主函数"""
    print("========================================")
    print("  GitHub API 部署工具")
    print("========================================")
    print()
    
    if not GITHUB_TOKEN:
        print("⚠️  需要GitHub访问令牌才能继续")
        print("请按照以下步骤获取令牌:")
        print("1. 访问 https://github.com/settings/tokens")
        print("2. 点击 'Generate new token (classic)'")
        print("3. 选择 'repo' 权限")
        print("4. 复制生成的令牌")
        print("5. 在此脚本中设置 GITHUB_TOKEN 变量")
        print()
        return
    
    # 要上传的文件列表
    files_to_upload = [
        {
            "local_path": "docs/index.html",
            "remote_path": "index.html",
            "commit_message": "添加技术支持页面"
        },
        {
            "local_path": "docs/privacy.html",
            "remote_path": "privacy.html",
            "commit_message": "添加隐私政策页面"
        },
        {
            "local_path": "docs/terms.html",
            "remote_path": "terms.html",
            "commit_message": "添加使用条款页面"
        },
        {
            "local_path": "docs/README.md",
            "remote_path": "README.md",
            "commit_message": "添加项目说明文档"
        }
    ]
    
    success_count = 0
    
    for file_info in files_to_upload:
        print(f"📤 上传 {file_info['remote_path']}...")
        
        # 读取文件内容
        content = read_file_content(file_info['local_path'])
        if content is None:
            continue
        
        # 上传文件
        if create_or_update_file(
            file_info['remote_path'],
            content,
            file_info['commit_message']
        ):
            success_count += 1
    
    print()
    print("========================================")
    if success_count == len(files_to_upload):
        print("  ✅ 所有文件上传成功!")
        print("========================================")
        print()
        print("🌐 访问以下URL验证 (1-5分钟后生效):")
        print(f"   技术支持: https://{REPO_OWNER}.github.io/{REPO_NAME}/")
        print(f"   隐私政策: https://{REPO_OWNER}.github.io/{REPO_NAME}/privacy.html")
        print(f"   使用条款: https://{REPO_OWNER}.github.io/{REPO_NAME}/terms.html")
        print()
        print("📋 请在 App Store Connect 中填写:")
        print(f"   隐私政策网址: https://{REPO_OWNER}.github.io/{REPO_NAME}/privacy.html")
        print(f"   技术支持网址: https://{REPO_OWNER}.github.io/{REPO_NAME}/")
        print()
        print("⚠️  还需要手动启用 GitHub Pages:")
        print(f"1. 访问 https://github.com/{REPO_OWNER}/{REPO_NAME}/settings/pages")
        print("2. Source: 选择 'Deploy from a branch'")
        print("3. Branch: 选择 'main'")
        print("4. Folder: 选择 '/' (root)")
        print("5. 点击 'Save'")
    else:
        print(f"  ❌ 部分文件上传失败 ({success_count}/{len(files_to_upload)})")
        print("========================================")
    
    print()

if __name__ == "__main__":
    main()