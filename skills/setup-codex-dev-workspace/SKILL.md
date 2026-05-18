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
4. Propose the initialization plan and target paths.
5. Create missing structure without overwriting user files.
6. Explain what was created and how to use it.

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

## Discovery Checklist

- current directory and Git root
- whether the current directory is a repo or a workspace containing repos
- existing `AGENTS.md`, `.agents/`, `docs/`, `scripts/`
- existing build/test files and CI config
- team language and documentation preference
- whether this initialization is global, workspace-level, or repo-level

## Deliverables

After initialization, report:

- project root
- created files/directories
- files skipped because they already existed
- next recommended command or Codex prompt
