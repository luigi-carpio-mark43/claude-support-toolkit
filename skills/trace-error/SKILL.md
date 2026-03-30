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

### Step 2: Locate the Error in Code
- Search for the error message string in the codebase
- If it's a stack trace, find the first application frame (com.mark43.*)
- Identify the method where the error originates

### Step 3: Understand the Context
- What operation was being attempted?
- What conditions trigger this error?
- Is this a known/expected error case or an unexpected bug?
- What data or state would need to be true for this to happen?

### Step 4: Determine the Root Cause
- Trace backward from the error to understand what went wrong
- Check if there are multiple paths that could produce the same error message
- Note whether the error is in application code or infrastructure

## Output Format

### Error Summary
One sentence: "This error means [X happened] because [Y condition was met]."

### What Was Happening
Plain-language explanation of what operation the system was trying to perform when it failed.

### Why It Failed
The specific condition that triggered the error. Include:
- The **file and line** where the error originates
- The **condition** that must be true for this error to occur
- Whether this is **expected behavior** (validation, missing permission) or a **bug**

### Possible Causes
Ranked by likelihood:
1. Most likely cause — what to check first
2. Second most likely — what to check if #1 doesn't apply
3. Less common causes

### What to Check
Actionable steps for Support:
- [ ] Questions to ask the customer
- [ ] Data or settings to verify
- [ ] Permissions to check
- [ ] Whether this is a known issue or needs escalation

### HTTP Status Code Reference (if applicable)
| Code | Meaning in Mark43 Context |
|------|--------------------------|
| 400 | Validation failed — bad input data |
| 401 | Not authenticated — session expired or not logged in |
| 403 | Not authorized — user lacks required ability |
| 404 | Entity not found — may be deleted, wrong department, or wrong ID |
| 409 | Conflict — concurrent edit or duplicate |
| 500 | Server error — unexpected failure, likely needs engineering |

## Important Rules
- **Plain language first.** Don't just paste the stack trace back.
- If the error message appears in multiple places in code, list ALL of them with context.
- **Distinguish between user-fixable issues and engineering bugs.** Be clear about which it is.
- If you can't find the exact error in the codebase, explain the error pattern and suggest where to look.
- **DO NOT suggest code changes.**
