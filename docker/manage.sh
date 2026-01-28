#!/bin/bash

# Docker 服务管理脚本
# 功能：启动、停止、重启所有 Docker 服务

# 设置脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 服务列表
SERVICES=("dpanel" "nacos" "postgres")

# 检查 Docker 是否运行
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        echo "Docker 未运行，请先启动 Docker"
        exit 1
    fi
}

# 创建网络
create_network() {
    if ! docker network ls | grep -q "gen-world-bridge"; then
        docker network create gen-world-bridge
    fi
}

# 启动服务
start_services() {
    check_docker
    create_network

    for service in "${SERVICES[@]}"; do
        if [ -d "$service" ] && [ -f "$service/docker-compose.yml" ]; then
            cd "$service"
            docker compose up -d
            cd "$SCRIPT_DIR"
        fi
    done
}

# 停止服务
stop_services() {
    for service in "${SERVICES[@]}"; do
        if [ -d "$service" ] && [ -f "$service/docker-compose.yml" ]; then
            cd "$service"
            docker compose down
            cd "$SCRIPT_DIR"
        fi
    done
}

# 重启服务
restart_services() {
    stop_services
    sleep 2
    start_services
}

# 主函数
main() {
    case "${1:-help}" in
        start)
            start_services
            ;;
        stop)
            stop_services
            ;;
        restart)
            restart_services
            ;;
        *)
            echo "用法: $0 {start|stop|restart}"
            exit 1
            ;;
    esac
}

main "$@"
