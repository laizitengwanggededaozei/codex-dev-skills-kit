# Workflow Rules

## Naming

- Requirement: REQ-YYYYMMDD-NNN-title.md
- Design: ADR-YYYYMMDD-NNN-title.md
- Review: REVIEW-YYYYMMDD-NNN-scope.md
- Bug fix: BUGFIX-YYYYMMDD-NNN-title.md
- Runbook: RUNBOOK-YYYYMMDD-NNN-topic.md
- Handoff: HANDOFF-YYYYMMDD-NNN-topic.md
- Temporary: TMP-YYYYMMDD-NNN-title.md

## Delivery Record

Every meaningful task should leave one of:

- review record
- bugfix record
- ADR/design note
- runbook
- handoff summary

## Complex Task Standard Workflow

This workflow is optional for small tasks, but mandatory once explicitly
triggered by the user or automatically triggered by task complexity. When it is
triggered, Codex must not jump directly into coding.

### Trigger Rules

Explicit trigger phrases include:

- "复杂任务"
- "长程任务"
- "标准流程"
- "完整流程"
- "先计划"
- "先审查"
- "先对齐"
- "使用 skill 计划"
- "编码前确认"

Automatic triggers include:

- zero-to-one product, project, or architecture work
- cross-repository tasks
- backend plus frontend or App work
- multiple pages, multiple bugs, or multiple user-facing symptoms
- permissions, data visibility, report statistics, branch filtering, SQL, or migration work
- unclear business ownership or unclear domain terms
- any task where a wrong implementation could change business data, security, or reporting口径

### Complexity Levels

#### Level 3: Extremely Complex

Examples:

- project from zero to one
- large architecture or platform migration
- multi-phase product design with unclear ownership

Required loop:

1. Requirement understanding
2. Skill usage plan
3. Plan review
4. Requirement/design alignment

Run at least three rounds before coding. After each round, Codex must summarize
what was clarified, what remains uncertain, and the suggested direction for the
next planning round. Coding starts only after the user explicitly confirms.

#### Level 2: Complex

Examples:

- backend plus frontend plus App bug repair
- multiple pages or multiple bugs in one request
- cross-end report/statistical口径 alignment

Required loop:

1. Requirement understanding
2. Skill usage plan
3. Plan review
4. Requirement/design alignment

Run at least one round. If the scope, data contract, permission boundary, or
business ownership remains broad, Codex must proactively ask whether to run a
second planning round or enter coding.

#### Level 1: Non-Trivial

Examples:

- single feature with unclear edge cases
- one bug with uncertain owner layer
- code change that touches shared APIs

Run one lightweight planning/alignment round before coding.

### Skill Usage Plan

Before execution, Codex must state which skills will be used and when. Use the
minimum set that fits the task.

| Stage | Typical Skill | Purpose |
|---|---|---|
| Requirement understanding | `codex-question-aligner` | Restate intent, split facts/assumptions/questions, identify what can be checked |
| Skill and plan alignment | `codex-design-alignment` | Align business boundary, affected systems, skill trigger timing, risks, documentation |
| Bug diagnosis | `codex-diagnose` | Build falsifiable hypotheses and verify root cause before fixing |
| Engineering execution | `engineering-ai-dev-suite` | Implement with existing project patterns after plan acceptance |
| Post-code review | `codex-code-review` | Review diff, regressions, API/data risks, missing tests |
| Durable workspace setup | `setup-codex-dev-workspace` | Confirm or create docs/ai-dev structure and naming |

`codex-design-alignment` can be paired with `codex-diagnose` when the diagnosis
depends on business ownership, permissions, or statistical口径. After coding,
`codex-code-review` should be paired with a goal-regression review against the
original task goals.

### Required Pre-Coding Documents

For triggered complex tasks, create both documents before coding:

- Plan/design document: `docs/ai-dev/20_设计方案/ADR-YYYYMMDD-NNN-title.md`
- Review document: `docs/ai-dev/30_审查记录/REVIEW-YYYYMMDD-NNN-scope.md`

Start complex-task plans, reviews, and final reports with this communication
status block:

```text
当前阶段：...
编码闸门：关闭 / 已打开：开始编码 / 已打开：自主执行
本轮目标：...
已确认：...
待确认：最多 1 个当前必须回答的问题
可后置确认：不影响当前阶段推进的问题
下一步：...
```

Use project terms consistently: `待确认`, `未确认项`, `编码闸门`, `编码授权`,
`下一步`, `验证缺口`, `剩余风险`, `目标回归`, and `审查结论`. Do not use
`阻断确认` as a section name; reserve `阻断` for real business or delivery
risks.

Design and review documents must be written in Chinese by default, unless the
user explicitly requests another language.

The plan/design document must follow `codex-design-alignment` and include:

- 目标
- 已确认事实
- 待确认问题
- task level and trigger reason
- user goals and non-goals
- affected repositories/modules
- skill usage timing
- business boundaries and data/API contracts
- risks
- recommended plan
- next step
- documents to preserve
- implementation plan
- verification plan

The review document must follow `codex-code-review` and include:

- findings first
- severity such as P0/P1/P2/P3
- file and line references where possible
- impact
- evidence
- recommendation
- verification gaps
- goal-regression coverage
- whether coding is allowed
- what requires user confirmation

### Coding Gate

Default rule: coding is blocked even after the user confirms the plan/design
and review documents.

Only these phrases open the coding gate:

1. `开始编码`
2. `自主执行`

Equivalent phrases must include action authorization such as start, execute,
modify, or implement. Phrases such as `确认方案`, `进入方案 C`, `继续`, `下一步`,
`完善一下`, or `同意这个方向` do not open the coding gate.

When the user answers `待确认` with new facts, corrections, or a redefined
requirement, treat it as `未确认项澄清`: restate the updated understanding,
separate confirmed facts, revised requirements, and remaining decisions, and
keep the coding gate closed unless the user explicitly says `开始编码` or
`自主执行`.

If coding has already happened before this workflow is triggered, pause coding
and run a replay review. Ask the user whether to skip replay review only if they
explicitly want to continue without it.

### Post-Coding Review

After coding, Codex must run:

1. Goal-regression review: check only the original task goals and requirements.
2. Diff/risk review: use `codex-code-review` to inspect changed files, API/data
   compatibility, permission risks, missing verification, and accidental scope.
3. Repository verification: run the affected repository checks from `AGENTS.md`.
4. Final report: summarize goal coverage, files changed, verification, known
   gaps, and links to the plan/review documents.

Do not let broad style commentary replace goal-regression review. The post-code
review should answer: "Did this solve the stated task, and what risk remains?"
