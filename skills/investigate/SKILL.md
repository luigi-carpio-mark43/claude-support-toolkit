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

## Output — Two Deliverables

Every investigation MUST produce **two outputs** in this order:

---

### Output 1: Case Note (displayed in conversation)

This is a concise summary the user can copy-paste into the **Notes section of a Salesforce Support case**. Display it directly in the conversation.

Format:

```
**Investigation Summary — [short description of the issue]**

**Root Cause (Most Likely):** [1-3 sentence plain-language explanation of what's happening and why]

**What to Verify:**
1. [actionable check]
2. [actionable check]
3. [actionable check]

**Questions for Customer:**
- [question]
- [question]

**Resolution Path:** [what needs to happen to fix it]
```

Rules for the case note:
- Keep it under 300 words
- No code references, file paths, or line numbers — this is for non-engineers
- Use plain language a support agent or customer success manager can understand
- Lead with the most likely cause, not an exhaustive list
- "What to Verify" items should be things Support can check (settings, database, customer questions) — not code

---

### Output 2: Detailed Analysis (exported to Desktop)

After displaying the case note, use the **Write tool** to export a detailed Markdown file to the user's Desktop:

**File path:** `C:\Users\LuigiCarpio\Desktop\[Topic]_Investigation.md`
- Replace `[Topic]` with a short descriptive name using underscores (e.g., `Case_Management_Permissions`, `Search_Results_Missing`)

The Markdown file must include ALL of the following sections:

```markdown
# [Issue Title] — Investigation

## Case Note Summary
[Copy of Output 1 above, so the file is self-contained]

---

## Detailed Analysis

### How It Works
Brief explanation of the normal flow (UI -> API -> Service -> DB).

### What Could Cause This
Numbered list of possible causes, ranked by likelihood. For each:
- What condition triggers it
- Where in the code it happens (file path + line number)
- What the user would see

### Permissions Required
List the abilities/permissions needed for this feature to work.

### Configuration / Feature Flags
Any feature flags, department settings, or config that could change behavior.

---

## Codebase Reference

### Backend
For each relevant backend file:
- File path and line numbers
- Function/method name and what it does
- How it contributes to the issue

### Frontend
For each relevant frontend file:
- File path and line numbers
- Component/selector name and what it does
- Conditions that enable/disable UI controls

---

## Quick Reference Table

| Symptom | Cause | File to Check |
|---|---|---|
| [symptom] | [cause] | [file:line] |

---

## What to Check
Actionable steps for Support:
- Questions to ask the customer
- Settings to verify
- Data to look up
- Whether to escalate and to whom
```

After writing the file, confirm to the user: "Detailed analysis exported to `C:\Users\LuigiCarpio\Desktop\[filename].md`"

---

## Important Rules
- **DO NOT suggest code changes.** This is investigation only.
- **Always explain in plain language** before referencing code.
- **Include file paths and line numbers** in the exported file (but NOT in the case note).
- **Rank causes by likelihood** — most common/probable first.
- If you're uncertain, say so and suggest what additional information would help.
- **Always produce both outputs.** Never skip the case note or the export.
