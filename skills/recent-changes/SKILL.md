---
title: Recent Changes
description: Check recent git history for a feature area to investigate regressions
tags: [support, git, changes, regression]
---

# Recent Changes

You are helping a **Product Support Specialist** investigate whether recent code changes could have caused an issue. This is commonly needed when a customer says "this was working before."

## Input

The user will provide:
- A feature area or file path to investigate
- Optionally, a timeframe ("in the last week", "since March 15")
- Optionally, the symptom that started happening

## Workflow

### Step 1: Identify the Relevant Files
- Based on the feature area, identify the key files across frontend, backend, and data layers
- Include Resource, Service, Repository, Entity, and React component files

### Step 2: Check Git History
For each relevant file or directory, run:
- `git log --oneline --since="timeframe" -- path/to/file` to see recent commits
- `git log --oneline -20 -- path/to/directory` if no timeframe given (last 20 commits)
- Check both `rms` and `mark43` repos as appropriate

### Step 3: Analyze the Changes
For each potentially relevant commit:
- Read the commit message to understand intent
- Use `git show <hash> -- path/to/file` to see what changed
- Assess whether the change could be related to the reported symptom

### Step 4: Check for Database Migrations
- Look for recent Flyway migration files that affect the relevant tables
- Check if any schema changes could impact the feature

### Step 5: Summarize Findings
- Connect the changes to the reported symptom
- Identify the most likely commit(s) that could have caused the issue

## Output Format

### Changes Summary
One paragraph: "In the last [timeframe], there were [N] changes to the [feature area]. The most likely related change is [description]."

### Recent Commits
| Date | Author | Commit | Summary | Likely Related? |
|------|--------|--------|---------|----------------|
| 2026-03-28 | dev@mark43 | abc1234 | "Fix case search filter" | Yes - changed search logic |

### Potentially Related Changes
For each commit that might be related:
- **Commit**: hash and message
- **Date**: when it was committed
- **Author**: who made the change
- **What changed**: plain-language summary of the diff
- **How it could cause the issue**: assessment of the connection

### Database Migrations
Any recent migrations affecting relevant tables.

### Recommendation
- Is this likely a regression from a recent change?
- Which commit(s) should engineering look at?
- Should Support escalate to engineering with this context?

## Important Rules
- **Run git commands in the correct repo directory** (`mark43` vs `rms`).
- **Focus on the relevant files** — don't dump the entire repo history.
- **Assess relevance** — not every recent change is related to every issue.
- If the feature area spans both repos, check both.
- **DO NOT suggest code changes or reverts.** Just report what changed.
