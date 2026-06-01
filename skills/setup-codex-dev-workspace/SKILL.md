---
name: setup-codex-dev-workspace
description: >
  Use when initializing a repository or multi-repository workspace for
  Codex-assisted development. Creates or updates a durable project working
  structure: AGENTS.md, docs/ai-dev indexes, requirements/design/review/bugfix/
  runbook/handoff folders, scripts/ai-dev, optional project-level skills, and
  naming conventions for long-running AI-assisted engineering work. Use for new
  projects, migrated projects, or teams standardizing Codex workflows.
---

# Setup Codex Dev Workspace

Initialize a project so Codex work is durable, searchable, and safe across a
multi-week development cycle.

## Quick Start

1. Identify the project root or workspace root.
2. Inspect existing docs and agent instructions.
3. Detect the machine and project layout from the current environment.
4. Decide whether this run will only create structure or will also populate
   project facts.
5. Propose the initialization plan and target paths.
6. Create missing structure without overwriting user files.
7. Record confirmed project facts and unknowns when the user asked for coding
   context initialization.
8. Explain what was created, what was learned, what remains unknown, and how to
   use it before coding.

Codex should normally perform initialization after inspecting the project. The
bundled script is an optional helper, not the default first step:

```bash
bash scripts/init-project.sh --target <project-root>
```

If the script is unavailable, follow
[`references/project-layout.md`](references/project-layout.md).

## Initialization Rules

- Do not overwrite existing `AGENTS.md` or docs unless the user explicitly asks.
- If a project already has docs, add an `docs/ai-dev/` layer instead of moving
  existing files.
- Do not hard-code machine-specific paths. Use `$HOME`, current working
  directory, Git root, or user-provided paths.
- If the project is a multi-repository workspace, initialize the workspace root
  and each active repository separately.
- Use stable English numeric prefixes for sorting.
- Use Chinese titles when the team works in Chinese; keep file prefixes English.
- Keep temporary notes under `docs/ai-dev/90_临时笔记/`, not scattered in the repo.
- Keep executable helper scripts under `scripts/ai-dev/`.
- Treat `AGENTS.md` as the entry summary and hard-rule file. Keep detailed
  project facts in `docs/ai-dev/01_PROJECT_CONTEXT.md`, project workflow rules
  in `docs/ai-dev/02_WORKFLOW_RULES.md`, and exploration handoffs in
  `docs/ai-dev/60_交接记录/`.
- Do not claim the project is understood when only the directory structure was
  created.
- Mark unknown facts as `TBD`, `待确认`, or `可后置确认`; do not guess.

## Discovery Checklist

- current directory and Git root
- whether the current directory is a repo or a workspace containing repos
- existing `AGENTS.md`, `.agents/`, `docs/`, `scripts/`
- existing build/test files and CI config
- README, runbooks, existing project docs, scripts, config files, and relevant
  environment examples
- source entrypoints, module boundaries, and common work directories
- build, test, lint, format, run, and manual verification commands
- data, API, permission, configuration, deployment, and external integration
  risks
- team language and documentation preference
- whether this initialization is global, workspace-level, or repo-level

## Optional Explorer Agents

When the runtime supports sub-agents and the user explicitly allows or asks for
agent exploration, Codex may spawn read-only explorer agents to inspect the
workspace faster. Explorer agents are optional acceleration, not a requirement.
If they are unavailable, the main agent performs the same read-only discovery
checklist itself.

Recommended explorer scopes:

- repository structure, language stack, build/test/lint/run commands
- existing `AGENTS.md`, README, docs, CI, scripts, config, and runbooks
- source entrypoints, module boundaries, clients, services, or integration
  boundaries
- data, API, permission, environment, deployment, and external-system risks

Each explorer result should include:

- scope inspected
- confirmed facts
- evidence paths
- uncertain findings
- `待确认` and `可后置确认`
- recommended destination: `AGENTS.md`,
  `docs/ai-dev/01_PROJECT_CONTEXT.md`,
  `docs/ai-dev/02_WORKFLOW_RULES.md`, or `docs/ai-dev/60_交接记录/`

The main agent is responsible for merging results, resolving conflicts, marking
unknowns, and writing files. Explorer agents must not directly edit project
files.

## Completion Levels

### Structure Initialization Complete

Use this status when the durable folders and templates exist, but project facts
have not been populated.

Minimum evidence:

- `AGENTS.md` exists or was intentionally skipped because it already existed
- `docs/ai-dev/` exists
- `scripts/ai-dev/` exists
- project-level `.agents/skills/` exists when requested
- no existing user file was overwritten without explicit approval

### Coding Context Initialization Complete

Use this status only after Codex has inspected and recorded enough project facts
to support a future coding task.

Minimum evidence:

- `docs/ai-dev/01_PROJECT_CONTEXT.md` records project purpose, repository or
  workspace type, repository map, source entrypoints, module boundaries, key
  commands, verification matrix, risks, documentation map, scripts map, and
  known unknowns
- `AGENTS.md` contains only the entry summary, hard rules, and links to detailed
  docs
- project-specific workflow rules are in `docs/ai-dev/02_WORKFLOW_RULES.md`
  when they exist
- exploration handoff notes are preserved under `docs/ai-dev/60_交接记录/` when
  useful
- unknown facts are clearly marked instead of inferred

## Deliverables

After initialization, report:

- project root
- created files/directories
- files skipped because they already existed
- completion level: structure initialization complete, coding context
  initialization complete, or structure complete with coding context pending
- confirmed project facts written
- unknown facts and whether they are `待确认` or `可后置确认`
- documents Codex should read before coding
- next recommended command or Codex prompt
