# Codex Dev Skills Kit

一套可迁移的 Codex skills 与项目初始化模板，用于把 AI 辅助开发中的需求对齐、
复杂任务流程、代码审查、故障诊断和交付记录沉淀成稳定的项目工作方式。

## Origin

This kit is inspired by and adapted from Matt Pocock's
[`skills`](https://github.com/mattpocock/skills) project. The upstream project
is licensed under the MIT License and promotes small, composable, adaptable
agent skills for real engineering work.

The bundled skills here are Codex-oriented adaptations rather than exact
upstream copies. They add Codex trigger metadata, `AGENTS.md` conventions,
Chinese collaboration templates, `docs/ai-dev/` delivery records, complex-task
coding gates, and multi-repository workspace initialization.

See [Third Party Notices](THIRD_PARTY_NOTICES.md) for attribution, license
notice, and the local-to-upstream skill mapping.

## What Is Included

| 模块 | 内容 |
| --- | --- |
| `skills/` | 可安装到 Codex 的工程、审查、诊断、需求对齐和项目初始化 skills |
| `templates/` | 新项目初始化用的 `AGENTS.md`、`docs/ai-dev` 和 `scripts/ai-dev` 模板 |
| `scripts/` | 安装 skills、初始化项目、一键迁移的脚本 |
| `docs/` | 中文操作手册、复杂任务标准流程、开发交流规范和 Codex CLI 指南 |

## Skills

| Skill | 用途 |
| --- | --- |
| `setup-codex-dev-workspace` | 初始化项目 AI 开发目录、规则和项目级 skill 拷贝 |
| `engineering-ai-dev-suite` | 通用工程执行、重构、迁移、文档和交付 |
| `codex-question-aligner` | 把模糊想法整理成精确问题和下一步提示 |
| `codex-design-alignment` | 编码前对齐需求、业务边界、影响范围和风险 |
| `codex-diagnose` | 诊断 bug、测试失败、接口异常和错误数据 |
| `codex-code-review` | 审查 diff、SQL、配置、PR 和交付风险 |

## Quick Start

推荐让 Codex 先检查现状，再执行安装和初始化：

```text
这是 Codex Dev Skills Kit 交付包目录：<KIT_DIR>
这是目标项目目录：<PROJECT_DIR>
请根据交付包帮我安装用户级 skills，并初始化该项目。
安装和初始化前先检查现状，避免覆盖已有文件。
```

也可以命令式执行：

```bash
bash <KIT_DIR>/scripts/bootstrap.sh --target <PROJECT_DIR>
```

默认安装目录：

```text
${CODEX_SKILLS_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}
```

可以通过 `CODEX_SKILLS_DIR` 覆盖安装目录。初始化项目时已有文件默认跳过，
只有明确加 `--force` 才会覆盖。

## Initialized Project Layout

初始化后目标项目会获得：

```text
<project-root>/
├── AGENTS.md
├── .agents/
│   └── skills/
├── docs/
│   └── ai-dev/
│       ├── 00_INDEX.md
│       ├── 01_PROJECT_CONTEXT.md
│       ├── 02_WORKFLOW_RULES.md
│       ├── 03_DELIVERY_LOG.md
│       ├── 04_COMMUNICATION_RULES.md
│       ├── 10_需求记录/
│       ├── 20_设计方案/
│       ├── 30_审查记录/
│       ├── 40_故障修复/
│       ├── 50_执行手册/
│       ├── 60_交接记录/
│       ├── 90_临时笔记/
│       └── 99_归档资料/
└── scripts/
    └── ai-dev/
```

## Delivery Check

迁移完成后至少检查：

- skills 目录下存在 6 个 bundled skills。
- 目标项目存在 `AGENTS.md`。
- 目标项目存在 `docs/ai-dev/02_WORKFLOW_RULES.md`。
- 目标项目存在 `docs/ai-dev/04_COMMUNICATION_RULES.md`。
- `02_WORKFLOW_RULES.md` 包含复杂任务标准流程。
- `04_COMMUNICATION_RULES.md` 包含交流状态块、待确认、可后置确认和编码闸门规则。
- `scripts/ai-dev/README.md` 已生成。
- 终端输出中没有意外覆盖；如有 `Skipped existing`，需要人工确认是否符合预期。

## Documentation

- [操作手册](docs/操作手册.md)
- [复杂任务标准流程](docs/复杂任务标准流程.md)
- [开发交流规范](docs/开发交流规范.md)
- [Codex CLI slash commands 中文指南](docs/Codex-CLI-slash-commands-中文指南.md)
- [更新记录](docs/更新记录.md)
- [Third Party Notices](THIRD_PARTY_NOTICES.md)

## Repository Notes

- 该仓库不包含业务代码。
- 初始化模板默认使用中文目录名，保留数字前缀方便排序。
- 复杂任务的编码闸门默认关闭，只有明确 `开始编码` 或 `自主执行` 才进入文件修改。
