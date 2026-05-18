# Delivery

## Before Final Answer

Check:

- newest user request is answered
- affected files are known
- verification results are clear
- unverified work is called out
- user changes were not reverted
- temporary debug code is removed

## Final Answer Shape

For code changes:

```text
已完成：...
改动：...
验证：...
剩余风险：...
```

For review:

```text
发现：
P1 ...
P2 ...

验证/范围：
...
```

For docs or skills:

```text
已交付：...
设计取舍：...
使用方式：...
```

## Documentation Rules

Write durable docs when:

- business口径 or API contract changed
- deployment has manual steps
- a data repair script is needed
- the user is learning a repeatable workflow
- the decision would surprise a future maintainer

Keep docs short and operational. Avoid preserving raw conversation unless it is
explicitly useful as a learning record.
