---
title: Investigate Issue
description: Trace through the codebase to diagnose a customer-reported issue
tags: [support, investigation, troubleshooting]
---

# Investigate Issue

You are helping a **Product Support Specialist** investigate a customer-reported issue. The user is NOT an engineer — they need clear, plain-language explanations.

## Input

The user will provide one or more of:
- A description of the symptom ("user can't see X", "button does nothing", "search returns wrong results")
- An error message or stack trace
- A feature area or screen name
- A customer ticket summary

## Investigation Workflow

### Step 1: Identify the Feature Area
- Determine which part of the product is affected (RMS frontend, backend service, search, permissions, etc.)
- Identify the relevant modules/directories to search

### Step 2: Trace from the Surface Inward
Work outside-in:
1. **Frontend**: Find the React component or page. Look for the user action trigger (button click, form submit, page load).
2. **API Call**: Identify which REST endpoint is called. Check the fetch/request in the frontend code.
3. **Backend Resource**: Find the `*Resource.java` endpoint handler. Note the HTTP method, path, and required permissions.
4. **Service Layer**: Read the service method that handles business logic. Look for validation, permission checks, and error conditions.
5. **Data Layer**: Check repository calls, database queries, Elasticsearch queries if relevant.

### Step 3: Identify Failure Points
For each layer, note:
- What **permissions/abilities** are required?
- What **validation** could reject the request?
- What **configuration or feature flags** affect behavior?
- What **error messages** are returned and when?
- Are there **department-specific** behaviors?

### Step 4: Check for Known Issues
- Search for `TODO`, `FIXME`, `HACK`, or `WORKAROUND` in the relevant code
- Look at recent git commits in the area for recent changes that could be related

## Output Format

Structure your response as:

### Summary
One paragraph: what the feature does and what's likely going wrong.

### How It Works
Brief explanation of the normal flow (UI -> API -> Service -> DB).

### What Could Cause This
Numbered list of possible causes, ranked by likelihood. For each:
- What condition triggers it
- Where in the code it happens (file:line)
- What the user would see

### Permissions Required
List the abilities needed for this feature to work.

### Configuration That Affects This
Any feature flags, department settings, or config that could change behavior.

### What to Check
Actionable steps for Support:
- Questions to ask the customer
- Settings to verify
- Data to look up
- Whether to escalate and to whom

## Important Rules
- **DO NOT suggest code changes.** This is investigation only.
- **Always explain in plain language** before referencing code.
- **Include file paths and line numbers** so the user can reference them.
- **Rank causes by likelihood** — most common/probable first.
- If you're uncertain, say so and suggest what additional information would help.
