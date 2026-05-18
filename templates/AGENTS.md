# AGENTS.md

## Project Scope

- Describe repository purpose here.
- List related repositories or services here.
- State production, staging, and local environment assumptions here.

## Default Workflow

- Inspect existing code and docs before editing.
- Preserve user changes and avoid unrelated refactors.
- Prefer existing project patterns, helpers, and test commands.
- Keep durable AI-assisted work notes under `docs/ai-dev/`.
- Keep project helper scripts under `scripts/ai-dev/`.

## Complex Task Standard Workflow

- This workflow is triggered either explicitly by the user, or automatically when Codex judges the task to be complex.
- Explicit triggers include phrases such as "复杂任务", "长程任务", "标准流程", "完整流程", "先计划", "先审查", or requests to use multiple skills before coding.
- Automatic triggers include zero-to-one projects, cross-repository changes, backend plus frontend work, multiple pages or multiple bugs, permission/data/reporting changes, migration plans, or unclear business ownership.
- When triggered, do not start coding immediately. First run requirement understanding, skill usage planning, plan review, and design alignment.
- For zero-to-one projects, repeat the understanding, skill planning, plan review, and design alignment loop at least three rounds. After each round, summarize the next planning direction and wait unless the user explicitly enters coding.
- For cross-end or multi-bug work, run at least one full loop. If scope or ownership is still broad, proactively ask whether to run a second loop or start coding.
- For other non-trivial tasks, run one lightweight loop before coding.
- Skill usage must be planned explicitly before execution. Typical mapping:
  - `codex-question-aligner`: clarify intent, facts, assumptions, questions, and next prompt.
  - `codex-design-alignment`: align business boundaries, affected systems, skill trigger timing,方案, risks, and documentation.
  - `codex-diagnose`: investigate bug root cause with falsifiable hypotheses before fixing.
  - `engineering-ai-dev-suite`: execute implementation with existing project patterns after the plan is accepted.
  - `codex-code-review`: review post-coding diff, regressions, missing tests, and data/API risks.
- For triggered complex tasks, create a plan/design document and a review document under `docs/ai-dev/` before coding. Use existing naming rules.
- Design and review documents must be written in Chinese by default, unless the user explicitly requests another language.
- Design documents must follow the intent of `codex-design-alignment`: state the goal, confirmed facts, pending decisions, affected systems, data/API/permission impact, risks, recommended plan, next step, and documents to preserve.
- Review documents must follow the intent of `codex-code-review`: findings first by severity, with concrete file/line references where possible, impact, evidence, recommendation, verification gaps, and goal-regression coverage.
- Complex task plans, reviews, and final reports must start with a concise communication status block: current stage, coding gate, current goal, confirmed facts, one current `待确认`, `可后置确认`, and next step.
- `待确认` should contain at most one current must-answer question by default. Put non-urgent questions under `可后置确认`.
- When the user answers `待确认` by adding facts, correcting Codex, or redefining the requirement, treat it as `未确认项澄清`: restate the updated understanding before proceeding.
- Coding requires an explicit gate-opening phrase. Only `开始编码`, `自主执行`, or an equivalent phrase containing action authorization such as start/execute/modify/implement opens the coding gate.
- Phrases such as `确认方案`, `进入方案 C`, `继续`, `下一步`, `完善一下`, or `同意这个方向` do not open the coding gate.
- After coding, run a goal-regression review against only the original task goals and requirements, then run diff/risk review and repository-specific verification.
- Final reports for complex tasks must include goal coverage, changed repositories/files, verification, remaining risks, and links to the plan/review documents.

## Verification

- Record build, lint, test, and manual verification commands here.
- Run `git status --short` and `git diff --check` when files were changed.
- State clearly when verification cannot be run.

## Code Style

- Prefer existing project patterns, APIs, services, components, and page structures.
- Reuse existing logic where practical.
- Avoid unrelated formatting or broad refactors.
- Do not introduce new dependencies unless explicitly required and approved.

## Safety

- Do not run destructive Git commands without explicit approval.
- Do not modify production data without an approved runbook.
- Document data repairs, permission changes, and deployment steps.
