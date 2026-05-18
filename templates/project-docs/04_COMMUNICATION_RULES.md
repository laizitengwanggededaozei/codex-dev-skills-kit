# Communication Rules

Use this file to keep complex-task communication short, clear, and safe.

## Status Block

Start complex-task plans, reviews, and final reports with:

```text
当前阶段：...
编码闸门：关闭 / 已打开：开始编码 / 已打开：自主执行
本轮目标：...
已确认：...
待确认：最多 1 个当前必须回答的问题
可后置确认：不影响当前阶段推进的问题
下一步：...
```

## Pending Decisions

- `待确认` should contain at most one current must-answer question by default.
- Put non-urgent questions under `可后置确认`.
- If the user answers with new facts, corrections, or a redefined requirement,
  treat it as `未确认项澄清`: restate the updated understanding before proceeding.

## Coding Gate

The coding gate is closed by default. Only these phrases open it:

1. `开始编码`
2. `自主执行`

Equivalent phrases must include action authorization such as start, execute,
modify, or implement.

The following do not open the coding gate: `确认方案`, `进入方案 C`, `继续`,
`下一步`, `完善一下`, `同意这个方向`, `先这样`.

