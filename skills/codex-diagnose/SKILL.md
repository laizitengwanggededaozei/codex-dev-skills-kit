---
name: codex-diagnose
description: >
  Use when investigating bugs, regressions, test failures, flaky behavior,
  wrong data, broken UI flows, failed builds, integration issues, or
  production/test-server defects. Builds a fast feedback signal, forms
  falsifiable hypotheses, verifies before fixing, removes temporary diagnostics,
  and records durable root cause notes when needed.
---

# Codex Diagnose

Diagnose before fixing.

## Workflow

1. Capture the symptom and expected behavior.
2. Find or create the fastest reliable reproduction signal before changing
   product code.
3. Confirm the failure matches the report.
4. List 3-5 ranked hypotheses.
5. For each hypothesis, state prediction and verification step.
6. Test one variable at a time.
7. Fix at the owning layer.
8. Verify the original failing path.
9. Remove temporary logs/debug code.
10. Document root cause when the issue affects data, deployment, or shared API.

## Good Signals

- failing unit/integration test
- exact API request and response
- deterministic UI path
- build/lint error
- database query proving data shape
- minimal command that fails before and passes after

## Feedback Loop Gate

The feedback signal is the gate for diagnosis. Do not move from investigation
to implementation until there is a concrete pass/fail signal that can verify
the reported symptom. If no reliable signal can be built, stop and report:

- what was tried
- why the signal is still missing
- what artifact, environment access, or manual verification is needed
- the safest next diagnostic step

## Output Shape

```text
现象：...
最快验证信号：...
假设：
1. ...
2. ...
验证结果：...
根因：...
修复：...
验证：...
需要沉淀：...
```

## Rules

- Treat the reproduction or verification signal as the first deliverable.
- Do not patch before at least one falsifiable hypothesis.
- Do not scatter broad logs.
- Do not change frontend and backend together unless ownership is proven.
- If verification cannot run, explain why and give manual verification steps.
