---
name: codex-question-aligner
description: >
  Use when the user gives a vague, emotional, long, mixed, or partially formed
  natural-language thought and wants Codex to quickly align understanding,
  extract assumptions, turn it into precise questions, clarify intent, and
  propose the next concrete ask. Similar to grill-me/grill-with-docs but
  lighter: it does not pressure-test the whole design first; it translates
  messy input into crisp questions, decisions, risks, and action prompts.
---

# Codex Question Aligner

Turn unclear natural language into precise, answerable questions and a shared
understanding.

## When To Use

Use this when the user says things like:

- "我说不清楚，你帮我整理一下"
- "你对齐一下我的想法"
- "我这一段话到底想问什么"
- "帮我转换成准确的问题"
- "我不知道怎么问"
- "先不要做，先理解我的意思"

## Workflow

1. Restate the user's intent in plain language.
2. Separate facts, assumptions, concerns, decisions, and actions.
3. Convert the input into 3-7 precise questions.
4. Mark which questions can be answered by reading code/docs and which need the
   user or team to decide.
5. Separate the one current `待确认` from `可后置确认` when the user would otherwise
   need to answer many questions.
6. Recommend the next single prompt the user should send.
7. If the user is anxious or self-deprecating, ignore the self-judgment and
   focus on the operational question.

## Output Shape

```text
我理解你的核心意思是：...

可以拆成这些精确问题：
1. ...
2. ...

我能直接查证的是：
- ...

需要你或团队确认的是：
- ...

可后置确认的是：
- ...

建议你下一句这样问：
...
```

## Rules

- Do not start implementation.
- Do not over-interview. Ask at most 3 follow-up questions.
- Prefer 1 current must-answer `待确认`; put non-urgent questions under
  `可后置确认`.
- If the user is correcting context or clarifying reality, treat it as
  `未确认项澄清`, restate the updated understanding, and do not imply coding
  authorization.
- Prefer concrete next prompts over abstract advice.
- Keep the user's language, but make it more precise.
- If the input contains a likely misconception, state it politely and give a
  corrected version.
