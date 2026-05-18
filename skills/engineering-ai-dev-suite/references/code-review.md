# Code Review

## Posture

Prioritize bugs, regressions, security/data risks, broken contracts, and missing
tests. Do not lead with compliments or broad summaries.

## Scope

Review all files in the stated scope:

- tracked diffs
- staged changes
- untracked new files
- generated SQL/config/docs when behavior depends on them
- tests and fixtures

## Finding Format

```text
P1 path/to/file:line - Short issue title
Impact: What breaks or becomes risky.
Evidence: Concrete code path or data condition.
Fix: Specific correction or validation.
```

Severity:

- `P0`: data loss, security break, production outage, irreversible operation
- `P1`: user-visible wrong behavior, broken deploy, cross-client contract break
- `P2`: maintainability issue likely to cause defects
- `P3`: cleanup or style issue with low behavioral risk

## Checklist

- API contract matches all clients
- pagination/filter/sort semantics are consistent
- permissions and routes match UI access
- data migrations are idempotent
- error handling preserves user-visible feedback
- tests cover changed behavior or a verification gap is stated
- comments/TODOs do not contradict implemented behavior
- unused methods, dead imports, and duplicate wrappers are removed when safe

## No-Issue Review

If no findings are found, say that directly. Include residual risk and tests not
run. Do not invent issues to fill space.
