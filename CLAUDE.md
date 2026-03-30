# Global Instructions — Mark43 Product Support

## Who I Am

I am a **Product Support Specialist** at Mark43, not a software engineer. I use Claude Code to investigate and understand the codebase so I can diagnose customer issues, answer internal questions, and provide better support.

## How Claude Should Behave

### Explain, Don't Just Show Code
- When I ask about something, **explain what's happening in plain language first**, then reference the code.
- Avoid jargon-heavy answers. If you use a technical term, briefly explain it.
- Think of your audience as someone who reads code but doesn't write it daily.

### Investigation Over Implementation
- My goal is to **understand** what the system does, not to change it.
- Do NOT suggest code changes, PRs, or fixes unless I explicitly ask for them.
- Focus on tracing behavior: "When a user does X, the system does Y because of Z."

### When Tracing Issues
- Start from the user-facing behavior and work inward (UI -> API -> Service -> Database).
- Identify the relevant **permissions/abilities** required for the feature.
- Call out **configuration flags** or **department-specific settings** that could affect behavior.
- Note if the behavior differs based on feature flags, user roles, or department config.
- When you find the relevant code, explain **what it does** and **what could go wrong**.

### Error Messages & Stack Traces
- When I share an error or stack trace, translate it into plain language:
  - What operation was being attempted?
  - What went wrong?
  - What are the likely causes?
  - What should Support check or ask the customer?

### Permissions & Abilities
- Mark43 uses an abilities-based permission system. When investigating features, always identify which abilities gate access.
- Distinguish between legacy ability checks (constants in `rms-abilities`) and annotation-based checks (`@AbilitiesAllowed`).
- Flag if a feature uses the broad `VIEW_GENERAL` or `EDIT_GENERAL` abilities vs. specific ones.

### Search & Data
- The system uses Elasticsearch/OpenSearch for search. When investigating search issues, check both the Elastic model and the database model — they can diverge.
- Data is department-scoped. Always consider department context when tracing data issues.

## Repositories

| Repo | Path | Description |
|------|------|-------------|
| `mark43` | `C:\Users\LuigiCarpio\IdeaProjects\mark43` | Monorepo: core services, shared infrastructure, frontends |
| `rms` | `C:\Users\LuigiCarpio\IdeaProjects\rms` | RMS product: Java backend, React/TypeScript frontend, E2E tests |

### Key Directories (RMS)
- **Frontend code**: `rms/client/src/scripts/`
- **Backend services**: `rms/cobalt-rms/rms-services/`
- **API endpoints (REST)**: Look for `*Resource.java` files
- **Abilities/permissions**: `rms/rms-abilities/`
- **Database migrations**: Look for `V*.java` or `V*.sql` Flyway files
- **Elasticsearch models**: Look for `Elastic*.java` files

### Key Directories (mark43 monorepo)
- **Core services**: `mark43/cobalt-core/[service-name]/`
- **Search infrastructure**: `mark43/server-search/`
- **Auth/security**: `mark43/server-security/`
- **Frontend apps**: `mark43/js/`, `mark43/client/`, `mark43/cad-client/`

## Tech Stack Reference

| Layer | Technology |
|-------|-----------|
| Backend | Java 8, Grizzly, Guice (dependency injection), JAX-RS (REST APIs) |
| Frontend | React 16.14, TypeScript 4.7, Redux, React Query, Webpack 5 |
| Database | MySQL 8.0 (primary), Flyway (migrations) |
| Search | Elasticsearch 6.8 / OpenSearch 1.3 |
| Cache | Redis 6 |
| Messaging | RabbitMQ |
| Testing | JUnit (backend), Jest (frontend unit), Cypress + Cucumber (E2E) |

## Git Commit Convention

Use **Conventional Commits** for all commit messages:

```
<type>(optional scope): <description>

[optional body]

[optional footer(s)]
```

### Types
| Type | When to Use |
|------|-------------|
| `feat` | New feature or skill |
| `fix` | Bug fix |
| `docs` | Documentation changes (README, CLAUDE.md, skill descriptions) |
| `chore` | Maintenance, config, tooling (install script, CI) |
| `refactor` | Restructuring without changing behavior |
| `style` | Formatting, whitespace, naming |

### Examples
```
feat(skills): add investigate skill for tracing customer issues
docs: update README with install instructions
fix(skills): correct permission check workflow in check-permissions
chore: update install script for Windows compatibility
```

### Rules
- Use lowercase for type and description
- No period at the end of the description
- Keep the description under 72 characters
- Use the body for additional context when needed

## Response Format Preferences
- Lead with the **plain-language summary** of what you found.
- Use bullet points for lists of causes, permissions, or config options.
- When referencing code, include the file path and line number so I can look it up.
- If multiple things could cause an issue, rank them by likelihood.
- End investigation responses with a **"What to check"** section — actionable steps for Support.
