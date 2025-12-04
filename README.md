# GitHub Actions 可重用工作流

本仓库提供通用的 GitHub Actions 工作流模板和部署配置，可在其他项目中重复使用，提高 CI/CD 配置的一致性和效率。

## 主要组件

- **可重用工作流**：位于 `.github/workflows/`，提供通用的 CI/CD 工作流模板
- **部署系统**：位于 `deployment/`，提供 Docker 容器化部署配置示例
- **工作流示例**：位于 `github/workflow/`，展示如何在其他项目中引用本仓库的工作流
- **自托管 Runner**：位于 `github-runner-org/`，提供 GitHub Actions 自托管 Runner 部署配置

## 目录结构

```
github-actions-workflows/
 ├── .github/workflows/      # 可重用工作流模板
 ├── deployment/             # 通用部署系统配置
 ├── github/workflow/        # 工作流使用示例
 ├── github-runner-org/      # 自托管 Runner 部署配置
 └── README.md               # 仓库概述
```

## 许可证

MIT License