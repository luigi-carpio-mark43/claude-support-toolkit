---
title: Trace Error
description: Decode an error message or stack trace into a plain-language explanation
tags: [support, error, troubleshooting]
---

# Trace Error

You are helping a **Product Support Specialist** understand an error message or stack trace from a customer. Translate technical errors into plain language with actionable next steps.

## Input

The user will provide one or more of:
- An error message (from the UI, API response, or logs)
- A Java stack trace
- A browser console error
- An HTTP status code and context
- A screenshot of an error
- A Sentry event JSON

## Workflow

### Step 1: Identify the Error Type
Classify the error:
- **Permission/Auth error** (401, 403, ability check failure)
- **Validation error** (400, precondition failure, missing required field)
- **Not Found error** (404, entity doesn't exist, deleted record)
- **Server error** (500, NullPointerException, unexpected state)
- **Search error** (Elasticsearch timeout, index issue)
- **Frontend error** (React render error, JavaScript exception)
- **Timeout/connectivity** (504, connection refused)
- **Infrastructure limit** (payload size, memory, Jackson constraints)

### Step 2: Locate the Error in Code
- Search for the error message string in the codebase
- If it's a stack trace, find the first application frame (com.mark43.*)
- Identify the method where the error originates

### Step 3: Understand the Context
- What operation was being attempted?
- What conditions trigger this error?
- Is this a known/expected error case or an unexpected bug?
- What data or state would need to be true for this to happen?

### Step 4: Extract Sentry Context (if provided)
If the user provides a Sentry event JSON, extract:
- **Environment** and **release version**
- **User info** (email, department ID)
- **Feature flags** from the `extra` field (especially flags relevant to the error path)
- **Service and server** from tags (which service, which pod)
- **Trace ID** for cross-service correlation
- **Command record ID** or other identifiers for engineering escalation

### Step 5: Determine the Root Cause
- Trace backward from the error to understand what went wrong
- Check if there are multiple paths that could produce the same error message
- Note whether the error is in application code or infrastructure
- **Distinguish between user-fixable issues and engineering bugs**

## Detailed Export Sections

The exported Markdown file (per the global Diagnostic Skill Output Format in CLAUDE.md) must use these sections:

```markdown
# [Error Title] — Error Trace

## Case Note Summary
[Copy of the case note from Output 1]

---

## Error Chain
Walk through each exception in the chain from outermost to root cause:
- Exception type and message (plain language)
- Where it occurs (file path + line number)
- What it means

## Root Cause Analysis
- The specific condition that triggered the error
- Whether this is expected behavior (validation, missing permission) or a bug/limitation
- The exact threshold, constraint, or check that failed

## Data Flow at Time of Error
Trace the operation from trigger to failure point:
1. User action / trigger
2. Frontend call
3. Backend endpoint
4. Service / worker processing
5. Point of failure

## Environment & Context
(Include if Sentry data was provided)
- Release version
- Service and pod
- Feature flags relevant to the error path
- Department/user context
- Trace ID and command record ID for escalation

## Codebase Reference

### Key Files
For each relevant file:
- File path and line numbers
- Function/method name and what it does
- How it contributes to the error

### Configuration
- Feature flags that affect this code path
- Jackson/infrastructure settings
- Any thresholds or limits

---

## Quick Reference Table

| Symptom | Cause | File to Check |
|---|---|---|
| [symptom] | [cause] | [file:line] |

## HTTP Status Code Reference (if applicable)

| Code | Meaning in Mark43 Context |
|------|--------------------------|
| 400 | Validation failed — bad input data |
| 401 | Not authenticated — session expired or not logged in |
| 403 | Not authorized — user lacks required ability |
| 404 | Entity not found — may be deleted, wrong department, or wrong ID |
| 409 | Conflict — concurrent edit or duplicate |
| 500 | Server error — unexpected failure, likely needs engineering |

---

## What to Check
Actionable steps for Support:
- Questions to ask the customer
- Settings to verify
- Data to look up
- Whether to escalate and to whom
- Engineering ticket details (trace ID, command record, etc.)
```

## Important Rules
- **Plain language first.** Don't just paste the stack trace back.
- If the error message appears in multiple places in code, list ALL of them with context.
- **Distinguish between user-fixable issues and engineering bugs.** Be clear about which it is.
- If you can't find the exact error in the codebase, explain the error pattern and suggest where to look.
- **DO NOT suggest code changes.**
