# 通用部署系统

适用于任意前后端项目的Docker容器化部署配置，支持自动化CI/CD部署。

## 目录结构

```
deployment/
├── docker-compose.yml  # Docker Compose配置
├── Dockerfile          # Docker镜像构建配置
└── README.md           # 说明文档
```

## 核心配置

### Docker Compose配置 (docker-compose.yml)
- **通用性**：镜像名称自动使用项目目录名
- **分支识别**：根据Git分支自动设置镜像标签
- **端口映射**：默认80:80，可根据项目需求修改

### Dockerfile
- **多阶段构建**：减小最终镜像体积
- **通用性**：适用于任意项目类型
- **可定制性**：可根据项目需求进行定制

## 分支策略

| 分支名称 | 镜像标签 | 环境类型 |
|---------|---------|---------|
| main    | main-YYYYMMDD-HHMMSS | 生产环境 |
| dev     | dev-YYYYMMDD-HHMMSS  | 开发环境 |
| 其他分支 | 分支名-YYYYMMDD-HHMMSS | 开发环境 |

## 使用方法

1. **复制配置**：将`deployment`目录复制到您的项目中
2. **修改Dockerfile**：根据项目类型选择合适的基础镜像
3. **调整端口**：在`docker-compose.yml`中修改端口映射
4. **推送代码**：推送代码到GitHub，触发自动部署

## 部署流程

1. **代码推送** → 触发GitHub Actions
2. **分支识别** → 自动生成带时间戳的镜像标签
3. **构建镜像** → 使用项目Dockerfile
4. **部署容器** → 启动服务并显示信息

## 最佳实践

- 为不同环境使用独立分支（main=生产，dev=测试）
- 根据项目需求调整端口和环境变量
- 生产环境建议使用HTTPS和域名
- 定期清理旧的Docker镜像和容器
