# AI Agent Design

## Skill Design

Design skills as small procedural capabilities, not long manuals.

Required:

- `SKILL.md`
- YAML frontmatter with `name` and `description`
- concise body with routing to optional references

Optional:

- `references/` for detailed workflows or domain knowledge
- `scripts/` for deterministic repeated operations
- `assets/` for output resources
- `agents/openai.yaml` for UI metadata

## Trigger Design

The description should say:

- when to use the skill
- what tasks it covers
- what discipline it applies
- what makes it different from generic model knowledge

Avoid vague descriptions such as "helps with development".

## Progressive Disclosure

Keep the main skill lean:

- startup rules
- task routing
- safety rules
- output expectations

Move detailed checklists, examples, and stack-specific guidance to references.
Do not duplicate the same rule in multiple files unless it is a safety invariant.

## Agentic Workflow Design

A useful agent workflow defines:

- entry condition
- context to inspect
- decision points
- allowed tools
- validation signal
- stop condition
- artifact to produce

Prefer workflows that make incorrect assumptions visible early.

## Evaluation

Validate a skill or workflow with realistic prompts:

- unfamiliar repo
- dirty worktree
- ambiguous requirement
- failing test
- cross-client API change
- documentation-only request

The skill is working if it improves decisions without forcing irrelevant ceremony.
