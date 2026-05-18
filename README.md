# Codex Dev Skills Kit

Portable Codex skills and project initialization kit for AI-assisted software
engineering.

迁移到新机器时，不要求用户手动执行脚本。打开 Codex，把本目录和目标项目目录告诉 Codex：

```text
这是 Codex Dev Skills Kit 交付包目录：<KIT_DIR>
这是目标项目目录：<PROJECT_DIR>
请根据交付包帮我安装用户级 skills，并初始化该项目。
安装和初始化前先检查现状，避免覆盖已有文件。
```

如果需要命令式一键迁移，可以让 Codex 执行：

```bash
bash <KIT_DIR>/scripts/bootstrap.sh --target <PROJECT_DIR>
```

默认会把 skills 安装到：

```text
${CODEX_SKILLS_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}
```

可以通过 `CODEX_SKILLS_DIR` 覆盖安装目录。初始化项目时已有文件默认跳过，
只有明确加 `--force` 才会覆盖。

迁移完成后至少检查：

- skills 目录下存在 `codex-question-aligner`、`codex-design-alignment`、`codex-diagnose`、`codex-code-review`、`engineering-ai-dev-suite`、`setup-codex-dev-workspace`
- 目标项目存在 `AGENTS.md`
- 目标项目存在 `docs/ai-dev/02_WORKFLOW_RULES.md`
- 目标项目存在 `docs/ai-dev/04_COMMUNICATION_RULES.md`
- `02_WORKFLOW_RULES.md` 包含复杂任务标准流程
- `04_COMMUNICATION_RULES.md` 包含交流状态块、待确认、可后置确认和编码闸门规则
- `AGENTS.md` 包含复杂任务自动触发、编码前确认、中文设计/审查文档规则
- 目标项目存在 `scripts/ai-dev/README.md`
- 终端输出中没有意外覆盖；如有 `Skipped existing`，需要人工确认是否符合预期

安装后日常使用看：

```text
docs/操作手册.md
```

复杂任务、长程任务、多仓库或多 bug 修复的标准流程看：

```text
docs/复杂任务标准流程.md
```
