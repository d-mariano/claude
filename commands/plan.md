---
allowed-tools: Glob, Grep, Read, Edit, TodoWrite, Write, WebFetch, WebSearch
argument-hint: [prd] [research]
description: Prepare a plan that implements the PRD or subcomponent that is informed by recent research $1.
---

We are going to work on $1.

Think hardest. Make a detailed plan to accomplish this, based on $2.

Identify files that need to be changed.

## Plan Outline
- Plan to implement only the functionality we need right now
- Write a short overview of what you are about to do
- Identify files that need to be changed and relevant snippets
- Write any new class and function names with 1-3 sentences about what they do
- Write test names and 5-10 words about behavior to cover
- Reinforce CLAUDE.md rules when relevant, especially around code clarity, simplicity, reuse, and third-party usage

## Avoid the Following
- Do not include plans for legacy fallback unless required or explicitly requested
- Fail fast and loud, avoid unnecessary error handling
- Do not over-engineer abstractions
- Avoid creating new types for interacting with third-party libraries when they already have their own

## Tasks
Tasks musts be outlined in the following format:
```markdown
## Tasks
- [ ] 1.0 Parent Task Title
  - [ ] 1.1 [Sub-task description 1.1]
  - [ ] 1.2 [Sub-task description 1.2]
- [ ] 2.0 Parent Task Title
  - [ ] 2.1 [Sub-task description 2.1]
- [ ] 3.0 Parent Task Title (may not require sub-tasks if purely structural or configuration)
```

## Target Audience

Assume the primary reader of the task list is a **junior developer** who will implement the feature with awareness of the existing codebase context.


Store your plan in /context/{feature|branch}/plan.md
