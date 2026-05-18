# Engineering Workflows

## Implementation

1. Find the nearest existing implementation of the same concept.
2. Trace the public path: route/API/command -> service/store/domain -> persistence
   or external boundary.
3. Identify the smallest layer that should own the change.
4. Patch only affected files.
5. Add or adjust tests when the behavior is shared, risky, or previously broken.
6. Verify with the narrowest reliable command, then broaden if needed.

## Refactor

Refactor only after behavior is understood.

Good refactors:

- remove real duplication
- clarify ownership
- reduce public surface
- isolate volatile integration code
- make tests easier without changing behavior

Avoid:

- style-only churn
- speculative abstraction
- renaming without domain value
- moving files before tests or call sites are understood

## Migration

1. Map source behavior, target behavior, and compatibility constraints.
2. Inventory routes, API clients, schemas, permissions, config, tests, and docs.
3. Move one vertical slice first.
4. Keep old and new paths from conflicting.
5. Provide fallback or rollback guidance when deployment order matters.
6. Document behavioral differences, not just file movement.

## API Cleanup

1. Search definitions by endpoint and exported name.
2. Search call sites by exact invocation.
3. Distinguish duplicate wrapper from same endpoint with different semantics.
4. Remove only unused or clearly redundant definitions.
5. Re-run definition and call-site searches.
6. Record decisions in a table when the user is learning or the blast radius is
   larger than one file.

## Data or Permission Change

1. Identify business key, technical key, and deployment environment.
2. Check existing rows before insert/update.
3. Prefer idempotent scripts.
4. Separate data change, permission grant, and UI route impact.
5. Include verification SQL and rollback notes.
