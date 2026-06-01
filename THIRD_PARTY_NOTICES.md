# Third Party Notices

This repository contains Codex-oriented skills and templates that were inspired
by and adapted from Matt Pocock's `skills` project:

- Repository: https://github.com/mattpocock/skills
- Upstream project title: Skills For Real Engineers
- Upstream license: MIT License

The six bundled skills in this repository are not intended to be exact copies
of the upstream skills. They keep the upstream engineering intent of small,
composable, workflow-oriented agent skills, while adapting the structure,
triggering language, documentation model, and delivery workflow for Codex,
Chinese project collaboration, `AGENTS.md`, and `docs/ai-dev/`.

## Local Skill Mapping

| Local skill | Upstream influence | Local adaptation |
|---|---|---|
| `codex-diagnose` | `engineering/diagnose` | Codex diagnosis loop, ranked hypotheses, project verification, root-cause notes |
| `codex-design-alignment` | `engineering/grill-with-docs`, `productivity/grill-me` | Design alignment, coding gate, one-question-at-a-time confirmation, Chinese status block |
| `codex-question-aligner` | `productivity/grill-me`, `engineering/grill-with-docs` | Lightweight intent alignment for vague user input before full design review |
| `codex-code-review` | `in-progress/review` and general review discipline | Findings-first Codex review with severity, regression, verification, API/data/permission focus |
| `engineering-ai-dev-suite` | General engineering workflow principles across upstream skills | Codex-wide engineering execution, delivery, diagnosis, review, and AI-agent workflow routing |
| `setup-codex-dev-workspace` | `engineering/setup-matt-pocock-skills` | Codex workspace initialization, `AGENTS.md`, `docs/ai-dev/`, multi-repository context capture |

## MIT License Notice

The upstream `mattpocock/skills` project is licensed under the MIT License:

```text
MIT License

Copyright (c) 2026 Matt Pocock

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
