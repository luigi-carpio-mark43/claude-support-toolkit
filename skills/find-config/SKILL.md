---
title: Find Config
description: Find configuration options and feature flags for a feature area
tags: [support, configuration, feature-flags]
---

# Find Config

You are helping a **Product Support Specialist** find all configuration options, feature flags, and department settings that affect a specific feature's behavior.

## Input

The user will provide:
- A feature name or area (e.g., "report approval", "case dashboard")
- Optionally, a specific behavior they want to toggle or understand

## Workflow

### Step 1: Search for Feature Flags
Search the codebase for:
- Feature flag checks (look for patterns like `isFeatureEnabled`, `featureFlag`, `isEnabled`, `FeatureFlag`)
- Configuration property lookups
- Department-level settings
- System properties

### Step 2: Search for Configuration Properties
Look for:
- Properties files or configuration classes related to the feature
- `@Value` annotations or property injection
- Server properties and environment variables
- Department-specific configuration tables/entities

### Step 3: Check Frontend Feature Gating
Search the React code for:
- Feature flag checks that show/hide UI elements
- Configuration-dependent rendering
- A/B testing or gradual rollout flags

### Step 4: Map Configuration to Behavior
For each configuration found:
- What is the default value?
- What does each setting do?
- Is it department-scoped or global?
- Who can change it? (Admin, Engineering, Support)
- Where is it set? (Database, properties file, environment variable)

## Output Format

### Configuration Summary
One sentence: "The [feature] is controlled by [N] configuration options."

### Feature Flags
| Flag Name | Default | What It Controls | Scope | Where Set |
|-----------|---------|-----------------|-------|-----------|

### Department Settings
| Setting | Default | What It Controls | How to Change |
|---------|---------|-----------------|---------------|

### Server/Environment Config
| Property | Default | What It Controls | Requires Restart? |
|----------|---------|-----------------|-------------------|

### Frontend Config
Any client-side configuration that affects UI behavior.

### Dependencies Between Settings
Note if any settings depend on or conflict with others (e.g., "Flag A must be enabled before Flag B takes effect").

### What to Tell the Customer
Plain-language explanation of what can be configured and who needs to change it.

## Important Rules
- **Be thorough** — check both repos, backend and frontend, properties and database.
- **Note the scope** — department-level vs. global makes a big difference for Support.
- **Note who can change it** — Support needs to know if they can fix it or need to escalate.
- **DO NOT suggest code changes.**
