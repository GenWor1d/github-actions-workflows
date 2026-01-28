# Docker 服务部署

本目录包含 AI 智能剧本游戏平台所需的基础服务 Docker 配置。

## 服务列表

| 服务 | 说明 | 端口 | 默认账号 |
|------|------|------|----------|
| **dpanel** | Docker 可视化管理面板 | 9999 | admin/admin123 |
| **nacos** | 微服务配置中心和服务发现 | 8848 | nacos/nacos |
| **postgres** | PostgreSQL 16 + PgVector 向量数据库 | 5432 | postgres/postgres |

## 快速启动

```bash
# 启动所有服务
./manage.sh start

# 停止所有服务
./manage.sh stop

# 重启所有服务
./manage.sh restart

# 查看服务状态
./manage.sh status
```

## 服务说明

### dpanel
Docker 容器可视化管理工具，提供 Web 界面管理容器、镜像、网络等资源。

### nacos
微服务架构的核心组件，提供服务注册与发现、配置管理功能。

### postgres
PostgreSQL 16 数据库，集成 PgVector 扩展，支持向量数据存储和检索。初始化脚本包含：
- 游戏平台业务表（用户、剧本、角色、游戏会话等）
- Nacos 配置中心表结构

## 网络配置

所有服务通过 `gen-world-bridge` 桥接网络互联，确保服务间通信。

## 数据持久化

各服务数据卷命名规范：
- `gen-world_dpanel_data` - dpanel 数据
- `gen-world_nacos_data` - nacos 数据
- `gen-world_nacos_logs` - nacos 日志
- `gen-world_postgres_data` - postgres 数据
