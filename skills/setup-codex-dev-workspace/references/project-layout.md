# Project Layout

## Standard Structure

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

## File Naming

Use sortable names:

| Type | Directory | Pattern |
|---|---|---|
| Requirement | `10_需求记录/` | `REQ-YYYYMMDD-NNN-title.md` |
| Design/ADR | `20_设计方案/` | `ADR-YYYYMMDD-NNN-title.md` |
| Code review | `30_审查记录/` | `REVIEW-YYYYMMDD-NNN-scope.md` |
| Bug fix | `40_故障修复/` | `BUGFIX-YYYYMMDD-NNN-title.md` |
| Runbook | `50_执行手册/` | `RUNBOOK-YYYYMMDD-NNN-topic.md` |
| Handoff | `60_交接记录/` | `HANDOFF-YYYYMMDD-NNN-topic.md` |
| Temporary note | `90_临时笔记/` | `TMP-YYYYMMDD-NNN-title.md` |
| Script | `scripts/ai-dev/` | `verb-object.sh` |

Examples:

```text
REQ-20260514-001-login-session.md
ADR-20260514-001-api-pagination-contract.md
REVIEW-20260514-001-uncommitted-diff.md
BUGFIX-20260514-001-login-blank-page.md
RUNBOOK-20260514-001-test-db-menu-repair.md
HANDOFF-20260514-001-frontend-backend-split.md
TMP-20260514-001-debug-token-refresh.md
```

## Repository Types

### Single Repository

Initialize once at the repository root.

### Multi-Repository Workspace

Initialize the workspace root with an index and shared rules. Then initialize
each backend/frontend/app repository separately when work begins there.

Workspace root should describe:

- repository map
- shared business terminology
- cross-repo verification expectations
- where shared runbooks and summaries live

Each repository should describe:

- local build/test commands
- local code style
- local docs and scripts
- repo-specific risks

## Initialization Completion Levels

### Structure Initialization Complete

This level means the durable collaboration structure exists. It does not mean
Codex has enough project-specific facts to code safely.

Required structure:

- `AGENTS.md`
- `docs/ai-dev/`
- `scripts/ai-dev/`
- optional project-level `.agents/skills/`

Use this level when templates were copied or confirmed, but project facts are
still placeholders or unknown.

### Coding Context Initialization Complete

This level means Codex has inspected the project and recorded enough confirmed
facts to reduce repeated discovery before future coding tasks.

Required facts:

- project purpose and repository responsibilities
- single-repo or multi-repo boundary
- source entrypoints, module boundaries, and common work directories
- build, test, lint, format, run, and manual verification commands
- data, API, permission, configuration, deployment, and external integration
  risks
- documentation and script locations
- known unknowns separated into `待确认` and `可后置确认`

## Long-Lived Context Layers

Do not place every discovered detail in `AGENTS.md`. Use layered persistence:

| Layer | Purpose |
|---|---|
| `AGENTS.md` | Entry summary, hard rules, default verification pointers, high-risk boundaries, and links to detailed docs |
| `docs/ai-dev/01_PROJECT_CONTEXT.md` | Full project facts needed before coding |
| `docs/ai-dev/02_WORKFLOW_RULES.md` | Project-specific workflow, validation order, naming, and review rules |
| `docs/ai-dev/60_交接记录/` | Exploration summaries, evidence paths, conflicts, unknowns, and handoff notes |

If explorer agents are used during initialization, their raw findings should be
merged and compressed by the main agent before being written into these layers.
Explorer results should not be copied wholesale into `AGENTS.md`.

## Complex Task Workflow

Projects initialized with this layout should treat complex tasks as a documented
workflow, not just an implementation request.

Trigger the complex task workflow when the user explicitly asks for a complex,
long-running, standard, planned, or reviewed process, or when Codex detects
cross-repository work, zero-to-one work, backend plus frontend/App changes,
multiple bugs/pages, permission/data/reporting changes, branch filtering, SQL,
migration, or unclear business ownership.

Before coding a triggered complex task, create:

| Artifact | Directory | Pattern |
|---|---|---|
| Plan/design | `20_设计方案/` | `ADR-YYYYMMDD-NNN-title.md` |
| Plan review | `30_审查记录/` | `REVIEW-YYYYMMDD-NNN-scope.md` |

Plan/design and review artifacts should be written in Chinese by default unless
the user explicitly asks for another language.

Plan/design artifacts should follow `codex-design-alignment`: goal, confirmed
facts, pending decisions, affected systems, data/API/permission impact, risks,
recommended plan, next step, and documents to preserve.

Review artifacts should follow `codex-code-review`: findings first, severity
ordering, file/line references where possible, impact, evidence,
recommendation, verification gaps, and goal-regression coverage.

Default coding gate: keep coding blocked even after the plan/design and review
artifacts are produced. Continue into file edits only when the user explicitly
says `开始编码`, `自主执行`, or an equivalent action authorization.

When the user answers pending questions with new facts or corrections, treat it
as `未确认项澄清`: restate the updated understanding, separate confirmed facts,
revised requirements, and remaining decisions, and keep the coding gate closed
unless explicit coding authorization is given.

After coding, create or update review/bugfix records as needed, and include a
goal-regression review against the original request before final delivery.
