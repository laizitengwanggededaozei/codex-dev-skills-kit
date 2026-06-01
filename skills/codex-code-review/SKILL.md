---
name: codex-code-review
description: >
  Use when reviewing code, current uncommitted changes, staged changes, PR
  diffs, generated SQL/config/docs, or multi-repository changes. Findings
  first. Prioritizes bugs, regressions, API incompatibility, permissions, data
  risks, pagination/filter semantics, missing tests, dead code, duplicate APIs,
  and deployment risks.
---

# Codex Code Review

Review code for real defects and delivery risk.

## Workflow

1. Identify review scope: uncommitted diff, staged diff, PR, files, or repo.
2. Include untracked files when relevant.
3. Read project rules, original goal/spec, and affected code paths.
4. Review along two axes: whether the change follows documented project
   standards, and whether it satisfies the original goal without scope creep.
5. Trace behavior across API, UI, data, permissions, config, and tests.
6. Output findings first, ordered by severity.
7. If no issue is found, say so and list verification gaps.
8. For complex-task reviews, state whether findings affect coding, submission,
   or acceptance, using the project's `编码闸门`, `验证缺口`, `剩余风险`, and
   `目标回归` terms.

## Severity

- `P0`: data loss, security break, production outage, irreversible operation
- `P1`: user-visible wrong behavior, broken deploy, cross-client contract break
- `P2`: maintainability issue likely to cause defects
- `P3`: cleanup or style issue with low behavioral risk

## Finding Format

```text
P1 path/to/file:line - 问题标题
影响：...
证据：...
建议：...
```

## Checklist

- original goal/spec coverage and scope creep
- documented project standards, `AGENTS.md`, ADRs, and workflow rules
- API request/response compatibility
- pagination, filtering, sorting, statistics semantics
- permissions, menus, routes, feature flags
- data migration and idempotency
- frontend state, loading, empty and error states
- backend transaction, branch/tenant/user isolation
- dead code, TODOs, duplicate API wrappers
- tests or explicit verification gaps

## Rules

- Do not lead with compliments.
- Do not include low-value style comments unless asked.
- Do not fix code during review unless the user asks to repair.
- Separate "violates project standards" from "misses original goal" when that
  distinction changes the recommendation.
- Cite exact files and lines when possible.
- Do not use `阻断确认` as a section name. Use `待确认` and `可后置确认` for
  user decisions; reserve `阻断` for real business or delivery risks.
