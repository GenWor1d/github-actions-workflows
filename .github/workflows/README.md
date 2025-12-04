# GitHub Actions 可重用工作流

本目录包含可在其他项目中重复使用的 GitHub Actions 工作流模板，用于简化 CI/CD 配置。

## 工作流列表

### 部署工作流 (deploy.yml)

自动化部署应用程序，支持：
- 基于分支自动生成镜像标签
- 停止并删除旧容器
- 清理7天前的旧镜像
- 构建新镜像并启动容器

## 输入参数

| 参数名 | 类型 | 描述 | 默认值 | 必须 |
|-------|------|------|--------|------|
| branch | string | 当前分支名称 | - | 是 |
| working-directory | string | 工作目录路径 | deployment | 否 |

## 输出参数

| 参数名 | 类型 | 描述 |
|-------|------|------|
| image-tag | string | 生成的镜像标签 |
| deployment-status | string | 部署状态 |

## 使用示例

```yaml
name: 部署项目
on:
  push:
    branches:
      - main
      - dev

jobs:
  deploy:
    uses: your-username/github-actions-workflows/.github/workflows/deploy.yml@main
    with:
      branch: ${{ github.ref_name }}
      working-directory: deployment
    secrets:
      DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
```

## 最佳实践

- 使用语义化版本标签引用工作流（如 `@v1.0.0`）
- 为不同环境创建独立的工作流
- 结合 GitHub Environments 使用环境特定的 secrets
- 定期更新工作流中的 action 版本

## 故障排除

1. **工作流无法运行**
   - 检查权限设置
   - 确保所有必填参数都已提供
   - 检查 secrets 是否正确配置

2. **部署失败**
   - 检查 Docker 配置
   - 验证工作目录路径
   - 查看运行日志获取详细错误信息

3. **镜像构建失败**
   - 检查 Dockerfile
   - 确保项目目录结构符合预期
   - 验证依赖项是否可用