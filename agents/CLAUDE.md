# Claude Code Agents

## Overview
This directory contains specialized agent configurations for Claude Code. Each agent is designed to handle specific types of tasks autonomously, using defined tools and models to achieve optimal results.

## Architecture

### Agent Configuration Format
Agents are defined using markdown files with YAML frontmatter:
- `name`: The agent identifier used when invoking via Task tool
- `description`: Clear explanation of when and why to use this agent
- `tools`: List of available tools the agent can use
- `model`: The Claude model to use (opus, sonnet, haiku)
- `color`: Terminal display color for the agent

### Agent Types

#### Development Agents
- **typescript-pro** (`typescript.md`): Advanced TypeScript development with strict type safety, generics, and enterprise patterns. Proactively used for TypeScript architecture and type system optimization.
- **python-pro** (`python-pro.md`): Modern Python 3.12+ development with async programming, performance optimization, and production-ready practices.
- **aws-cdk-agent** (`aws-cdk-agent.md`): AWS CDK infrastructure as code specialist.

#### Review Agents
- **design-review** (`design-review.md`): Comprehensive UI/UX design reviews using Playwright for automated testing across viewports. Follows WCAG 2.1 AA standards and best practices from top tech companies.
- **pragmatic-code-review** (`pragmatic-code-review.md`): Pragmatic code quality reviews focused on practical improvements.

#### Infrastructure Agents
- **crawler** (`crawler.md`): Codebase documentation specialist that generates and maintains CLAUDE.md files throughout the repository.

## Data Flow

### Agent Invocation
1. Main Claude instance identifies task that matches agent specialty
2. Task tool invoked with `subagent_type` parameter
3. Agent receives detailed prompt with context and expected output
4. Agent executes autonomously using its allowed tools
5. Agent returns single comprehensive report
6. Main instance processes and presents results to user

### Agent Communication
- Agents are stateless - no ongoing dialogue
- Communication via comprehensive initial prompts
- Results returned in structured reports
- For large codebases, crawler can spawn sub-agents that communicate via generated CLAUDE.md files

## Testing
Test agents by:
1. Using appropriate slash commands that invoke them (e.g., `/design-review`, `/crawl`)
2. Directly invoking via Task tool with proper parameters
3. Verifying agent uses only its allowed tools
4. Checking output format matches expected structure

## Resources
- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [Agent Best Practices](https://docs.claude.com/en/docs/claude-code/agents)
- YAML frontmatter follows standard markdown conventions

## Best Practices
- Use specific, descriptive agent names
- Write clear descriptions that explain when to use proactively
- Limit tools to what's necessary for the agent's purpose
- Choose appropriate model based on task complexity
- Provide comprehensive prompts with expected output format
- Design agents to be composable and focused on single responsibilities
