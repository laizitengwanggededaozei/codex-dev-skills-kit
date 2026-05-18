---
name: codex-design-alignment
description: >
  Use when validating a feature idea, technical plan, architecture decision,
  migration plan, cross-team proposal, or unclear requirement before
  implementation. Aligns business intent, domain terms, constraints, risks,
  alternatives, and documentation. Inspired by grill-with-docs/grill-me: ask
  focused questions, inspect code/docs when possible, and produce a
  decision-ready summary.
---

# Codex Design Alignment

Align a plan before implementation.

## Workflow

1. Read local project instructions and relevant docs when available.
2. Restate the proposed goal and scope.
3. Identify business terms, system boundaries, affected clients, data impact,
   permissions, deployment order, and rollback needs.
4. Inspect code/docs for answers before asking the user.
5. Ask one focused question at a time when a decision is blocked.
6. If the user provides new facts or corrections while answering questions,
   treat it as `未确认项澄清`: restate the updated understanding before moving on.
7. Produce a decision-ready summary and a recommended next action.

## Question Types

- What business rule makes this necessary?
- Which system owns the behavior?
- Which clients or integrations are affected?
- What data shape or API contract changes?
- What happens to old data or old clients?
- What must be verified before release?
- What should be documented for future maintainers?

## Output Shape

```text
当前阶段：...
编码闸门：关闭 / 已打开：开始编码 / 已打开：自主执行
目标：...
已确认：...
待确认：...
可后置确认：...
风险：...
建议方案：...
下一步：...
需要沉淀的文档：...
```

## Rules

- Do not implement until scope and ownership are clear.
- Do not treat `确认方案`, `进入方案 C`, `继续`, `下一步`, or similar wording as
  permission to edit files.
- The coding gate opens only when the user explicitly says `开始编码`,
  `自主执行`, or an equivalent action authorization.
- Prefer code/docs evidence over assumptions.
- Ask at most one blocking question at a time.
- If the decision is durable or surprising, create or update an ADR/design note.
