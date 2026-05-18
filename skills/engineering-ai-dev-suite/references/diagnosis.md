# Diagnosis Workflow

## Loop

1. Reproduce or define the fastest reliable signal.
2. Confirm the symptom matches the report.
3. Generate 3-5 ranked hypotheses.
4. For each hypothesis, state:
   - prediction
   - quickest falsification step
   - expected evidence
5. Change one variable at a time.
6. Fix at the owning layer.
7. Add a regression test or documented verification.
8. Remove temporary logs, debug code, and unused helpers.

## Good Signals

- failing unit or integration test
- specific API request and response
- deterministic UI path
- build/lint error
- database query proving data shape
- minimal script or command that fails before and passes after

## Anti-Patterns

- adding broad logs before forming a hypothesis
- fixing the first suspicious line without tracing data flow
- changing frontend and backend simultaneously without proving ownership
- leaving TODO/debug comments after the fix
- declaring success without rerunning the original failing path

## Root Cause Note

Document root cause when:

- production data may be affected
- multiple clients share the behavior
- deployment order matters
- the bug exposes a hidden business rule
- future maintainers could reasonably reintroduce it
