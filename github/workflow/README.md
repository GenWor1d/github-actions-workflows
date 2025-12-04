# GitHub Actions 工作流使用示例

本目录包含如何在其他项目中引用 `github-actions-workflows` 仓库中可重用工作流的示例配置。

## 目录结构

```
github/workflow/
├── deploy-demo.yml     # 部署工作流使用示例
└── README.md           # 说明文档
```

## 部署工作流示例 (deploy-demo.yml)

展示如何在您的项目中引用本仓库的 `deploy.yml` 工作流。

### 关键配置

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

- **name**: 工作流名称（可自定义）
- **on**: 触发事件，这里配置为 push 到 main 和 dev 分支时触发
- **uses**: 工作流引用路径，格式为 `{owner}/{repo}/{path}/{workflow_file}@{ref}`
- **with**: 输入参数
  - `branch`: 当前分支名称
  - `working-directory`: 工作目录路径
- **secrets**: 传递给工作流的密码（需在 GitHub 仓库设置中配置）

## 使用步骤

1. 将 `deploy-demo.yml` 复制到您项目的 `.github/workflows` 目录
2. 修改配置：
   - 工作流名称
   - 触发事件
   - 工作流引用路径（替换用户名和仓库名）
   - 输入参数
   - Secrets
3. 提交代码到您的项目仓库
4. 在 GitHub 仓库设置中配置所需的 Secrets

## 最佳实践

- 使用语义化版本标签（如 `@v1.0.0`）而不是分支引用工作流
- 为不同环境创建独立的工作流文件
- 结合 GitHub Environments 使用环境特定的 secrets
- 添加清晰的注释说明各部分作用

## 故障排除

1. **工作流无法触发**
   - 检查触发事件配置
   - 确保分支名称与配置一致

2. **工作流引用错误**
   - 检查仓库路径
   - 确保工作流文件存在
   - 验证引用的分支/标签/提交哈希

3. **Secrets 错误**
   - 检查 Secrets 是否正确配置
   - 确保 Secrets 名称匹配

4. **输入参数错误**
   - 检查所有必填参数
   - 验证参数类型
   - 检查参数值格式

## 参考文档

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [重用工作流文档](https://docs.github.com/en/actions/using-workflows/reusing-workflows)