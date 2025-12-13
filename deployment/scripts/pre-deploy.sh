#!/bin/bash

# 预部署脚本示例
# 执行自定义的预部署任务

echo "========================================"
echo "开始执行自定义预部署脚本"
echo "当前时间: $(date)"
echo "当前目录: $(pwd)"
# 直接搜索并打印 .env 文件路径（含完整路径）
ENV_FILE=$(find "$GITHUB_WORKSPACE" -name ".env" -type f 2>/dev/null | head -n 1)
echo "[DEBUG] 搜索到的 .env 文件完整路径: $ENV_FILE"

echo "========================================"

# 加载环境变量
if [ -f "$GITHUB_WORKSPACE/.env" ]; then
    echo "[DEBUG] 从工作区根目录加载环境变量..."
    source "$GITHUB_WORKSPACE/.env"
    echo "[DEBUG] 环境变量加载成功"
    echo "[DEBUG] BRANCH_NAME: $BRANCH_NAME"
    echo "[DEBUG] PROJECT_NAME: $PROJECT_NAME"
    echo "[DEBUG] IMAGE_TAG: $IMAGE_TAG"
elif [ -f ".env" ]; then
    echo "[DEBUG] 从当前目录加载环境变量..."
    source ".env"
    echo "[DEBUG] 环境变量加载成功"
else
    echo "[DEBUG] 未找到 .env 文件，跳过环境变量加载"
fi

# 可以在这里添加自定义的预部署任务
# 例如：
# - 数据库备份
# - 配置文件检查
# - 依赖检查
# - 其他自定义操作

echo "预部署检查完成！"
echo "========================================"