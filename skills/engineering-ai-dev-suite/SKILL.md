---
name: engineering-ai-dev-suite
description: >
  Use when Codex is asked to perform professional software engineering work
  across arbitrary codebases: planning, implementation, refactoring, bug
  diagnosis, code review, test design, API cleanup, documentation, migration,
  release preparation, or AI-agent workflow design. Applies senior engineering
  judgment plus LLM-agent operating discipline: inspect before editing,
  preserve user work, prefer existing patterns, make falsifiable plans, verify
  changes, document durable decisions, and manage context with progressive
  disclosure.
---

# Engineering AI Dev Suite

General-purpose Codex skill for software engineering and AI-agent-assisted
development. It is project-agnostic by default; only load project-specific rules
when the repository provides them.

## First Principles

1. Inspect before editing. Let the codebase reveal its architecture.
2. Preserve user work. Never revert unrelated changes.
3. Prefer existing patterns over new abstractions.
4. Make assumptions explicit and testable.
5. Implement narrowly, verify concretely, document durably.
6. Treat context as scarce. Load only the references needed for the current task.

## Startup Workflow

1. Read local agent/project instructions when present:
   - `AGENTS.md`
   - `CLAUDE.md`
   - `.agents/`
   - `.codex/`
   - repository docs such as `README.md`, `CONTRIBUTING.md`, `docs/`
2. Identify repository boundaries and dirty worktree state.
3. Classify the task:
   - implementation
   - diagnosis
   - review
   - refactor
   - migration
   - documentation
   - skill or agent workflow design
4. Load the matching reference file below.
5. For complex tasks, respect the project coding gate: do not edit formal files
   unless the user explicitly says `开始编码`, `自主执行`, or an equivalent action
   authorization.

## Reference Routing

- Implementation, refactor, migration:
  [`references/engineering-workflows.md`](references/engineering-workflows.md)
- Bug diagnosis or test failure:
  [`references/diagnosis.md`](references/diagnosis.md)
- Code review:
  [`references/code-review.md`](references/code-review.md)
- AI-agent skill, prompt, workflow, or documentation design:
  [`references/ai-agent-design.md`](references/ai-agent-design.md)
- Delivery checklist and final reporting:
  [`references/delivery.md`](references/delivery.md)

## Operating Rules

- Search with fast semantic anchors first: names, endpoints, exports, routes,
  migrations, tests, and configuration.
- Do not invent build commands. Discover them from package files, build files,
  scripts, CI config, or local docs.
- Add dependencies only when the existing stack cannot reasonably solve the task.
- Add comments only for business rules, non-obvious invariants, or dangerous
  operational constraints.
- When user asks for a review, findings come first. Summaries are secondary.
- For complex tasks, keep communication state concise: current stage, coding
  gate, current goal, confirmed facts, one current `待确认`, `可后置确认`, and
  next step.
- If the user corrects facts or clarifies requirements, treat that as
  `未确认项澄清` before continuing implementation.
- When information may be stale or external, verify from primary sources.
- When a task affects data, permissions, security, money, health, or production
  operations, prefer explicit validation steps and rollback notes.

## Deliverables

For code work, produce:

- changed files
- behavior changed
- verification run
- known gaps or risks

For docs or skill work, produce:

- target audience
- activation/usage model
- file structure
- maintenance rules
- example prompts or execution steps

Keep outputs concise and actionable.
