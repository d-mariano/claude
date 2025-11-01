# 🤖 Claude Code Workflows & Commands

A comprehensive collection of slash commands, agents, and workflows for Claude Code that implements a structured, iterative approach to AI-assisted software development. ✨

## Overview

This repository provides a complete workflow system for building features with Claude Code, from initial ideation through implementation and validation. The workflow emphasizes structured planning, incremental development, and continuous validation to maximize code quality while maintaining developer control.

## 🔄 Core Workflow (WIP)

The recommended development cycle follows four distinct phases:

1. **💡 Ideation** - Start with an idea (use Gemini Deep Dive or similar tools for exploration)
2. **📋 Requirements & Research** - Use `/prdgen` to create a comprehensive PRD from your idea
   - Interactively asks clarifying questions ❓
   - Automatically uses `@researcher` agent to become a subject matter expert 🔬
   - Continuously researches as you refine the PRD, as needed 📚
   - **⚠️ Known Issue** - Sometimes an extra call to the researcher is needed (WIP)
3. **🗺️ Planning** - Use `/plan` to create a detailed implementation plan based on the PRD
4. **⚡ Execution** - Use `/execute` to implement the plan with continuous validation

This structured approach ensures clarity at each stage and prevents scope creep while maintaining flexibility to adapt as you learn.

## 📟 Available Slash Commands

### 🚀 Development Workflow Commands

- **`/prdgen [idea]`** - Interactively generate a Product Requirements Document from an initial idea
  - Asks clarifying questions to gather requirements
  - Automatically uses `@researcher` agent throughout the process
  - Researches before asking questions, after receiving answers, and after PRD changes
  - Maintains research file alongside the PRD
  - Outputs to `/context/[nnn]-{feature}/prd-[nnn].md` and `research-[nnn].md`
  - Target audience: junior developers

- **`/research [topic]`** - Standalone research command (optional, as research is integrated into `/prdgen`)
  - Reads through related code and documentation
  - Conducts web searches on frameworks and libraries
  - Identifies third-party types and alternative approaches
  - Outputs to `/context/{feature}/research.md`
  - Use this for ad-hoc research outside the main workflow

- **`/plan [prd] [research]`** - Create detailed implementation plan
  - Identifies files that need changes
  - Lists new classes, functions, and test names
  - Includes specific tasks in checkbox format
  - Reinforces CLAUDE.md principles
  - Outputs to `/context/[nnn]-{feature}/plan-[nnn].md`

- **`/execute [plan]`** - Implement the plan with TDD and validation
  - Follows Test Driven Development practices
  - Marks tasks complete incrementally with commits
  - Runs full test suite before each commit
  - Tracks progress in `/context/{feature}/progress.md`

- **`/taskgen [prd]`** - Generate task list from a PRD
- **`/taskexec [tasks]`** - Execute a specific task list
- **`/explore [topic]`** - Alternative research command for gaining context, does not output to a file

### 🔍 Code Quality Commands

- **`/pragmatic-code-review`** - Conduct pragmatic code review on current branch
  - Focuses on practical concerns over theoretical perfection 🎯
  - Reviews pending changes systematically

- **`/design-review`** - Comprehensive UI/UX design review
  - Uses Playwright for automated browser testing 🎭
  - Validates accessibility and responsiveness ♿
  - Ensures world-class design standards ✨

- **`/simplify`** - Refactor and simplify existing code 🧹

### 🛠️ Utility Commands

- **`/crawl`** - Generate/update CLAUDE.md documentation files
  - Recursively documents codebase structure and patterns 🕷️
  - Updates after feature changes

- **`/pr`** - Create pull request with proper formatting 📬
- **`/next`** - Determine next steps in development workflow 🧭
- **`/quick`** - Quick task execution for simple changes ⚡

### 🎨 Custom Workflow Commands

- **`/my-developer-plan`** - Custom planning workflow
- **`/my-developer-review`** - Custom review workflow

## 🤝 Available Agents

Specialized agents provide focused capabilities for complex tasks:

- **`@planner`** 🗺️ - Creates detailed implementation plans
- **`@researcher`** 🔬 - Conducts comprehensive research and maintains research files
- **`@executer`** ⚡ - Implements code following strict TDD principles
- **`@claude-crawler`** 🕷️ - Generates and maintains CLAUDE.md files
- **`@design-review`** 🎨 - Automated UI/UX validation with browser testing
- **`@pragmatic-code-review`** 🔍 - Code quality assessment
- **`@python-pro`** 🐍 - Python 3.12+ expertise with modern tooling
- **`@typescript`** 📘 - TypeScript expertise with advanced patterns
- **`@aws-cdk-agent`** ☁️ - AWS CDK infrastructure development

## 📁 Context Management

The workflow uses a structured `/context/` directory to organize artifacts:

```
/context/
  [nnn]-{feature-name}/
    prd-[nnn].md          # Product requirements
    research-[nnn].md     # Research findings
    plan-[nnn].md         # Implementation plan
    progress.md           # Execution progress
```

This structure keeps all related materials together and enables easy reference across workflow stages.

## 💎 Development Principles

This workflow adheres to principles defined in `CLAUDE.md`:

- 🗑️ Delete more than you add - complexity compounds into disasters
- 🏗️ Follow SOLID and KISS principles
- 🚀 Assume MVP mindset for rapid iteration
- 🧠 Trust your research - don't read files repeatedly
- 💥 Fail fast and loud, not silently
- 🧪 Use Test Driven Development by default
- ✅ Validate every code block: lint, compile, test
- 🎯 Maximize code coverage quality, not just quantity

## 🌟 Inspirations & Resources

This workflow synthesizes ideas from several AI-assisted development approaches:

### 📦 Repository Resources

- **[ai-dev-tasks](https://github.com/snarktank/ai-dev-tasks)** by Ryan Carson - Structured markdown templates for breaking features into reviewable chunks
- **[claude-code-workflows](https://github.com/actiondavestep/claude-code-workflows)** by Patrick Ellis - Automated review workflows for code, security, and design

### 🎥 Video Resources

- **[Advanced Context Engineering for Agents](https://www.youtube.com/watch?v=VIDEO_ID)** - Dex Horthy (HumanLayer) at YC Root Access (Aug 25, 2025)
- **[Claude Code: Tips and Tricks](https://www.youtube.com/watch?v=hOqgFNlbrYE)** - Featuring Galen Ward's workflow ([Slides](https://docs.google.com/presentation/d/1TbgpuCJ8ZuulW4i1I0FE0xnArjivViEl/edit?slide=id.p1#slide=id.p1))

### 🔗 Other Resources

- **[The Ralph Wiggum Technique](https://ghuntley.com/ralph/)** by Geoffrey Huntley - Continuous automation loop for AI coding agents

## 🎯 Getting Started

1. **⚙️ Set up your environment** - Ensure Claude Code is installed and configured
2. **📖 Review CLAUDE.md** - Understand the development principles
3. **💡 Start with an idea** - Begin the workflow with `/prdgen [your idea]`
   - The command will research automatically as you work through clarifying questions 🔬
4. **🗺️ Plan the implementation** - Use `/plan` with your generated PRD
5. **⚡ Execute and validate** - Use `/execute` to implement with continuous testing
6. **✅ Review before finalizing** - Use review commands before merging

## 🏗️ Command Architecture

Commands are defined using markdown files with YAML frontmatter:

```yaml
---
allowed-tools: Bash, Glob, Grep, Read, Edit, Write
argument-hint: [topic]
description: Brief description of command purpose
---
```

The command body contains the prompt template with `$1`, `$2`, etc. for arguments.

## ⭐ Best Practices

- **🔄 Follow the workflow** - prdgen (with integrated research) → plan → execute
- **🧠 Trust the research** - `/prdgen` handles research automatically; don't repeat it
- **✅ Validate incrementally** - Don't batch commits
- **🤝 Use agents** for specialized processing
- **📁 Organize context** by feature or branch name
- **💎 Reference principles** from CLAUDE.md in all work
- **🧪 Test continuously** - Run suite before every commit

## 🧪 Testing

Test commands by:
1. Running with appropriate arguments
2. Verifying tool restrictions are respected
3. Checking output locations
4. Validating argument substitution

## 📚 Resources

- 📖 [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- ⚡ [Slash Commands Guide](https://docs.claude.com/en/docs/claude-code/slash-commands)
- 📟 Command definitions in `/commands/` directory
- 🤝 Agent definitions in `/agents/` directory
- 💎 Global principles in `CLAUDE.md`

## 📄 License

See `LICENSE` file for details.

## 🤝 Contributing

Contributions welcome! This is a living collection of workflows that evolves with experience and community input. 🌱
