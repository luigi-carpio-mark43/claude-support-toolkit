---
title: Analyze HAR
description: Parse a browser HAR file to extract API call evidence for support investigations
tags: [support, har, network, troubleshooting]
---

# Analyze HAR

You are helping a **Product Support Specialist** analyze a HAR (HTTP Archive) file captured from browser DevTools. Extract the meaningful API traffic, flag problems, and produce evidence suitable for support cases and engineering escalations.

## Input

The user will provide:
- A file path to a `.har` file (JSON format exported from browser DevTools > Network tab)
- Optionally, context about what they were reproducing or investigating

## Analysis Workflow

### Step 1: Extract API Calls

HAR files contain all network traffic including static assets, analytics, and telemetry. Filter down to what matters:

**Include:**
- Requests to `/rms/api/`, `/cad/api/`, `/jms/`, `/notifications/api/`, or other Mark43 service endpoints
- Any request that returned a 4xx or 5xx status code

**Exclude (noise):**
- Static assets: `.js`, `.css`, `.svg`, `.png`, `.ico`, `.woff`, `.map` files
- Analytics/telemetry: LogRocket (`logrocket`), Segment (`segment`), Pendo (`pendo`), Amplitude (`amplitude`), Sentry (`sentry`), LaunchDarkly (`launchdarkly`)
- CDN/external: `googleapis`, `gstatic`, `cloudflare`, `cdn`
- Notification polls (include a count but don't list each one individually unless they error)

### Step 2: Build Timeline

Create a chronological table of API calls:

| Time (UTC) | Method | Endpoint | Status | Description |
|---|---|---|---|---|
| HH:MM:SS | GET/POST/PUT/DELETE | `/path` | 200/400/500 | What this call does |

For each call, note:
- **Method and URL** (strip the domain, keep the path)
- **HTTP status code** — flag anything non-2xx
- **Response time** (from `timings.wait` — the server processing time)
- **Brief description** of what the call does (based on the endpoint name and payload)

### Step 3: Inspect Request/Response Payloads

For each API call, check:

**Request:**
- `postData.text` — the request body (parse as JSON for readability)
- `x-application-context` header — contains route name and entity IDs (Mark43-specific)
- `x-m43-api-version` header — the deployed version

**Response:**
- `content.text` — the response body (parse as JSON)
- Success/failure: Mark43 APIs return `{"success": true/false, ...}`
- Error messages: `{"success": false, "error": "..."}`
- **Missing fields** — compare response against what the frontend expects (e.g., missing `permissionSet`, missing `id`)

**Mark43-Specific Headers:**
- `x-m43-correlation-id` — unique request ID for log tracing (critical for engineering escalation)
- `x-m43-request-id` — same as correlation ID in most cases
- `x-m43-infra-id` — identifies which pod/server handled the request

### Step 4: Flag Issues

Look for these patterns:

**Errors:**
- 4xx responses (validation failures, permission denials, not found)
- 5xx responses (server errors, timeouts)
- `"success": false` in response body

**Missing Data:**
- Response fields that are null or absent when they should have values
- Responses that are significantly smaller than expected (truncated?)

**Sequence Problems:**
- Expected API calls that are missing (e.g., a fetch that should happen but doesn't — evidence of a frontend bug)
- Calls happening in the wrong order
- Duplicate calls (same endpoint called multiple times unnecessarily)

**Performance:**
- Server response times (`timings.wait`) over 2 seconds
- Large response payloads that could cause frontend lag

**Authentication/Session:**
- 401 responses (session expired)
- 403 responses (permission denied)
- Missing cookies or auth headers

### Step 5: Cross-Reference with Investigation Context

If the user has already run `/investigate` or `/trace-error` on this issue:
- Check whether the HAR evidence confirms or contradicts the investigation's theory
- Call out specific responses that match the predicted root cause
- Note any surprises — things the HAR shows that the code investigation didn't predict

## Detailed Export Sections

The exported Markdown file (per the global Diagnostic Skill Output Format in CLAUDE.md) must use these sections:

```markdown
# [Topic] — HAR Analysis

## Case Note Summary
[Copy of the case note from Output 1]

---

## Capture Details
- Tenant, API version, capture window, total entries
- User context (from x-application-context header)
- Browser and platform (from user-agent)

## API Call Timeline
Chronological table of all meaningful API calls with method, endpoint, status, timing, and description.

## Payload Analysis
For each significant API call (errors, key data fetches, saves):
- Request body (formatted JSON)
- Response body (formatted JSON)
- What's notable, missing, or wrong

## Issues Found
Numbered list of problems identified, ranked by severity:
- Error responses with their messages and correlation IDs
- Missing data in responses
- Missing expected API calls (calls that should have happened but didn't)
- Performance concerns

## Mark43 Request Context
- Correlation IDs for engineering escalation
- Infra IDs (which pods handled the requests)
- API version
- Application context (route, entity IDs)

---

## Quick Reference Table

| Finding | Evidence | Correlation ID |
|---|---|---|
| [what was found] | [which API call shows it] | [correlation ID for engineering] |

---

## What to Check
- Whether the HAR confirms or contradicts the investigation theory
- Additional reproduction steps if the HAR was incomplete
- Correlation IDs to provide to engineering for log analysis
```

## Important Rules
- **DO NOT suggest code changes.** This is evidence analysis only.
- **Always explain findings in plain language** before showing raw JSON.
- **Highlight correlation IDs** — these are critical for engineering to find logs.
- **Note what's missing** from the HAR. A HAR that doesn't show a particular call might be evidence that the call never happened (frontend bug) or that the recording didn't capture it.
- If the HAR file is very large, focus on API calls first and only dig into static assets if the user asks.
- If response bodies are compressed or encoded and unreadable, note this rather than guessing at the content.
- **Sanitize sensitive data** in the case note — don't include full auth tokens, session cookies, or PII in the output. Correlation IDs and entity IDs are fine.
