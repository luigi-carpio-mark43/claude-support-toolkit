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
- **Permission patterns differ by repo** — know which pattern to look for:
  - **RMS / mark43 / CAD**: `@AbilitiesAllowed` annotations + legacy `ensurePermission()` checks. Ability constants in `rms-abilities/` or `cad-abilities/`.
  - **JMS**: Spring Security `@PreAuthorize` + `UserAbility` enum (56 abilities). Syncs abilities with RMS.
  - **Security-alerts**: `@Authorization(abilities = {"View Usage Logs"})` annotation.
- Distinguish between legacy ability checks (constants in `rms-abilities`) and annotation-based checks (`@AbilitiesAllowed`).
- Flag if a feature uses the broad `VIEW_GENERAL` or `EDIT_GENERAL` abilities vs. specific ones.

### Search & Data
- The system uses Elasticsearch/OpenSearch for search. When investigating search issues, check both the Elastic model and the database model — they can diverge.
- Data is department-scoped. Always consider department context when tracing data issues.

## Repositories

| Repo | Path | Description |
|------|------|-------------|
| `mark43` | `C:\Users\LuigiCarpio\IdeaProjects\mark43` | Monorepo: core services, shared infrastructure, frontends |
| `rms` | `C:\Users\LuigiCarpio\IdeaProjects\rms` | RMS product: Java 8 backend (Guice/JAX-RS), React/TypeScript frontend |
| `cad` | `C:\Users\LuigiCarpio\IdeaProjects\cad` | CAD product: real-time emergency dispatch (Java + React/Electron) |
| `jms` | `C:\Users\LuigiCarpio\IdeaProjects\jms` | Jail Management System: booking, detainee tracking (Spring Boot + GraphQL) |
| `api-gateway` | `C:\Users\LuigiCarpio\IdeaProjects\api-gateway` | External API gateway: OpenAPI contracts, proxies to backend services |
| `security-alerts` | `C:\Users\LuigiCarpio\IdeaProjects\security-alerts` | Security alert ingestion and management (Spring Boot + React) |

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

### Key Directories (CAD)
- **Frontend code**: `cad/cad-fe/` (React + MobX + Electron)
- **Backend services**: `cad/cad-services/`
- **REST API**: `cad/cad-rest-server/` and `cad/cad-api/`
- **Abilities/permissions**: `cad/cad-abilities/`
- **Database migrations**: `cad/cad-migration/`
- **Real-time server**: `cad/cad-realtime-server/` (WebSockets)
- **E2E tests**: `cad/cad-qa/`

### Key Directories (JMS)
- **Frontend code**: `jms/client/` (React + TypeScript + Vite)
- **Backend API**: `jms/api/` (Spring Boot + GraphQL)
- **GraphQL schemas**: `jms/api/src/main/resources/graphql/` (look for `*.graphqls` files)
- **Abilities/permissions**: `jms/jms-abilities/` + `jms/api/.../security/UserAbility.java`
- **Database migrations**: `jms/api/src/main/resources/db/migration/`
- **E2E tests**: `jms/e2e/`

### Key Directories (Security-Alerts)
- **Frontend code**: `security-alerts/src/main/client/` (React 18 + TanStack)
- **Backend API**: `security-alerts/src/main/java/com/mark43/alert/` (Spring Boot)
- **Database migrations**: `security-alerts/src/main/resources/db/migration/`

### Key Directories (API Gateway)
- **API contracts (OpenAPI specs)**: `api-gateway/api-contracts/v2/`
- **Lambda functions**: `api-gateway/lambda/`
- **Generated client libraries**: `api-gateway/libraries/`

## Tech Stack Reference

The stack varies by repo. When investigating, check which repo you're in.

### RMS / mark43 / CAD (Legacy Stack)
| Layer | Technology |
|-------|-----------|
| Backend | Java 8, Grizzly, Guice (dependency injection), JAX-RS (REST APIs) |
| Frontend | React 16.14, TypeScript 4.7, Redux, React Query, Webpack 5 |
| Frontend (CAD) | React 17+, TypeScript, **MobX** (not Redux), Vite, **Electron** (desktop) |
| Database | MySQL 8.0, Flyway (migrations) |
| Search | Elasticsearch 6.8 / OpenSearch 1.3 |
| Cache | Redis 6 |
| Messaging | RabbitMQ |
| Real-time | WebSockets (CAD dispatch) |
| Testing | JUnit (backend), Jest (frontend), Cypress + Cucumber (E2E) |

### JMS (Modern Stack)
| Layer | Technology |
|-------|-----------|
| Backend | **Java 21**, **Spring Boot 3**, Hibernate ORM |
| API | **GraphQL** (Spring GraphQL, not REST) |
| Frontend | React 17, TypeScript 4.9, **Apollo Client** (GraphQL), Vite |
| Database | MySQL 8.0, Flyway (migrations) |
| Testing | JUnit 5, Vitest (frontend), Cypress (E2E) |

### Security-Alerts (Modern Stack)
| Layer | Technology |
|-------|-----------|
| Backend | **Java 21**, **Spring Boot 3** |
| Frontend | React 18, TypeScript, **TanStack Router/Query** |
| Database | MySQL 8.0, **DynamoDB** (alert rules), Flyway |
| Messaging | **AWS SQS** (alert ingestion), **AWS SES** (email) |
| Auth | JWT-based via Mark43 auth-lib |

### API Gateway
| Layer | Technology |
|-------|-----------|
| Specs | OpenAPI / AsyncAPI (576 YAML files) |
| Runtime | AWS API Gateway, AWS Lambda (Java) |
| Auth | API key (`x-api-key` header) |

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

## Diagnostic Skill Output Format

The following are **diagnostic skills** and must always produce two outputs: `/investigate`, `/trace-error`, `/search-diagnostics`, `/support-brief`.

### Output 1: Case Note (displayed in conversation)

A concise summary for copy-pasting into the **Notes section of a Salesforce Support case**. Display it directly in the conversation.

Format:

```
**[Title] — [short description of the issue]**

**Root Cause (Most Likely):** [1-3 sentence plain-language explanation of what's happening and why]

**What to Verify:**
1. [actionable check]
2. [actionable check]
3. [actionable check]

**Questions for Customer:**
- [question]
- [question]

**Resolution Path:** [what needs to happen — workaround, escalation, config change, etc.]
```

Rules for the case note:
- Under 300 words
- No code references, file paths, or line numbers — this is for non-engineers
- Plain language a support agent or customer success manager can understand
- Lead with the most likely cause, not an exhaustive list
- "What to Verify" = things Support can check (settings, data, customer questions), not code

### Output 2: Detailed Analysis (exported to Desktop)

After displaying the case note, use the **Write tool** to export a detailed Markdown file:

**File path:** `C:\Users\LuigiCarpio\Desktop\[Topic]_[SkillType].md`
- `[Topic]`: short descriptive name with underscores (e.g., `Export_PDF_Size_Limit`, `Search_Results_Missing`)
- `[SkillType]`: `Investigation`, `Error_Trace`, `Search_Diagnostic`, or `Support_Brief`

The file must always include:
1. A copy of the case note (so the file is self-contained)
2. Detailed analysis with code references (file paths + line numbers)
3. A quick reference table mapping symptoms to causes and relevant files
4. Actionable next steps for Support

Each diagnostic skill defines its own detailed sections in its skill file.

Rules for the export:
- Include file paths and line numbers in the export (but NOT in the case note)
- Rank causes by likelihood
- **Always produce BOTH outputs** — never skip the case note or the export
- After writing, confirm: "Detailed analysis exported to `C:\Users\LuigiCarpio\Desktop\[filename].md`"
