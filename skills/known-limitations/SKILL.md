---
title: Known Limitations
description: Search for known issues, TODOs, and workarounds in a feature area
tags: [support, limitations, known-issues]
---

# Known Limitations

You are helping a **Product Support Specialist** find known issues, limitations, and workarounds that exist in the code for a specific feature area. This helps set expectations and determines whether an issue is known vs. new.

## Input

The user will provide:
- A feature name or area to investigate
- Optionally, a specific behavior they suspect might be a known limitation

## Workflow

### Step 1: Identify the Relevant Code
- Find the key files for the feature area across frontend, backend, and data layers

### Step 2: Search for Code Markers
Search the relevant files and surrounding code for:
- `TODO` — planned but not yet implemented
- `FIXME` — known broken, needs fixing
- `HACK` — workaround in place
- `WORKAROUND` — explicit workaround
- `XXX` — problematic code needing attention
- `NOTE` or `WARN` — important caveats
- `@deprecated` — deprecated functionality
- `@SuppressWarnings` — suppressed checks that might hide issues

### Step 3: Search for Defensive Code
Look for patterns that suggest known edge cases:
- Try/catch blocks with comments explaining why
- Null checks with comments
- Special-case handling for specific departments or scenarios
- Retry logic or fallback mechanisms
- Feature flag guards (may indicate partially-rolled-out fixes)

### Step 4: Check for Comment-Documented Limitations
Search for comments that describe:
- Known issues or bugs
- Unsupported scenarios
- Performance limitations
- Compatibility notes
- Intentional behavior that might seem like a bug

### Step 5: Check Git Blame for Context
For significant TODOs/FIXMEs, check when they were added and the commit message for context.

## Output Format

### Known Issues Summary
One paragraph: "The [feature area] has [N] documented issues/limitations in the code."

### Documented Issues
For each TODO/FIXME/HACK found:
| Marker | Location | Description | Added | Context |
|--------|----------|-------------|-------|---------|
| `TODO` | file:line | "Handle edge case for X" | 2025-10 | Part of initial implementation |

### Known Workarounds
Any HACK/WORKAROUND markers with explanation of what they work around and why.

### Defensive Code Patterns
Edge cases the code explicitly handles — these suggest known pain points.

### Feature Flags / Partial Rollouts
Any feature flags guarding code in this area that suggest in-progress work.

### Deprecated Functionality
Any deprecated methods/endpoints that customers might still be hitting.

### Support Implications
For each finding:
- Is this something customers might hit?
- Is there a workaround they can use?
- Should Support set expectations about this limitation?
- Is this actively being worked on (based on recency of commits)?

## Important Rules
- **Search broadly** — TODOs in related files can be relevant too.
- **Include the surrounding code context** so the user understands the implication.
- **Don't alarm unnecessarily** — a TODO doesn't mean something is broken, it means it's incomplete.
- **DO NOT suggest code changes.**
