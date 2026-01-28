# GitHub Actions Runner 部署配置

本目录包含 GitHub Actions 自托管 Runner 的 Docker 部署配置，适用于组织级 Runner 管理。

## 目录结构

```
github-runner-org/
├── .env                  # 环境变量配置
├── docker-compose.yml    # Docker Compose 配置
├── runner-data/          # Runner 数据持久化目录
└── README.md             # 说明文档
```

## 什么是自托管 Runner？

自托管 Runner 允许在自己的基础设施上运行 GitHub Actions 工作流，适用于需要特殊环境、访问私有资源、控制基础设施或节省成本的场景。

## 环境要求

- Docker 和 Docker Compose
- GitHub 组织/仓库管理员权限
- 网络连接（与 GitHub 通信）

## 快速开始

### 1. 配置环境变量

编辑 `.env` 文件，设置必要参数：

```env
GITHUB_REPOSITORY_URL=https://github.com/your-organization/your-repository
GITHUB_TOKEN=your-personal-access-token
RUNNER_GROUP=default
RUNNER_LABELS=linux,x64,my-runner
RUNNER_NAME_PREFIX=my-organization-runner
```

### 2. 生成 GitHub 个人访问令牌

- 仓库级 Runner：需要 `repo` 权限
- 组织级 Runner：需要 `admin:org` 权限

### 3. 启动 Runner

```bash
docker-compose up -d
```

### 4. 验证

在 GitHub 组织/仓库的设置页面中，检查 Runner 是否已注册并在线。

## 管理 Runner

### 查看日志
```bash
docker-compose logs -f github-runner
```

### 停止
```bash
docker-compose down
```

### 更新
```bash
docker-compose pull
docker-compose up -d
```

### 删除
```bash
docker-compose down
rm -rf runner-data
```

## 最佳实践

- 限制 Runner 访问权限
- 定期检查 Runner 状态
- 备份 Runner 数据和配置
- 根据需求调整 Runner 数量和资源
- 定期更新 Runner 镜像

## 故障排除

- **无法注册**：检查令牌有效性、网络连接和 GitHub URL
- **离线**：查看日志、检查网络和容器状态
- **工作流无法运行**：检查标签匹配、组权限和资源充足性

## 参考文档

- [GitHub Actions 自托管 Runner 文档](https://docs.github.com/en/actions/hosting-your-own-runners)
- [创建个人访问令牌](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [myoung34/github-runner 镜像文档](https://github.com/myoung34/docker-github-actions-runner)
