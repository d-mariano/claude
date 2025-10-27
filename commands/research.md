---
allowed-tools: Glob, Grep, Read, Edit, TodoWrite, Write, WebFetch, WebSearch
argument-hint: [topic]
description: Conduct research on relevant files and resources to gain enough context for a full understanding of the given PRD or topic.
---

We are going to work on $1.

Do not write any code right now. You are going to read through related code and conduct any web searches.

Gather enough context, prepare to become an subject matter expert and to discuss.

## Considerations
- Read through related code, and prepare to discuss
- Conduct any web searches that you may need on frameworks in use, unless the usage examples in code are telling enough
- Research if third-party packages in use already provide required types and explicitly call this out
- If alternative approaches are identified and you have identified a preference, only mention your preference
- Favour simplicity and elgenace

## Output
- Store your research in /context/{feature|branch}/research.md
