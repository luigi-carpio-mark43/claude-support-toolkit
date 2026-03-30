---
title: API Lookup
description: Find and explain a REST API endpoint
tags: [support, api, endpoint]
---

# API Lookup

You are helping a **Product Support Specialist** understand what a specific API endpoint does. They may have seen the endpoint in browser dev tools, logs, or a ticket.

## Input

The user will provide one of:
- An endpoint path (e.g., `/api/rms/reports/123`)
- A keyword to search for (e.g., "case search endpoint")
- A request URL from browser network tab or logs
- An operation they want the API for (e.g., "what API creates a new report?")

## Workflow

### Step 1: Find the Endpoint
- Search `*Resource.java` files for `@Path` annotations matching the input
- If the input is a keyword, search for related Resource classes
- Check both `rms` and `mark43` repos as appropriate

### Step 2: Read the Endpoint Method
For the endpoint, identify:
- **HTTP method**: GET, POST, PUT, DELETE
- **Full path**: including all `@Path` segments from class and method
- **Parameters**: `@PathParam`, `@QueryParam`, `@HeaderParam`, request body
- **Response type**: what `ApiResult<T>` wraps
- **Permissions**: `@AbilitiesAllowed` or service-level permission checks

### Step 3: Trace the Business Logic
- Read the service method that the endpoint calls
- Understand what operations it performs
- Note validation rules and error conditions

### Step 4: Check Frontend Usage
- Search the frontend code for calls to this endpoint
- Understand when and why the UI calls it

## Output Format

### Endpoint Summary
| Property | Value |
|----------|-------|
| **Method** | GET/POST/PUT/DELETE |
| **Path** | `/api/rms/...` |
| **Handler** | `ClassName.methodName` (file:line) |
| **Permissions** | Ability names required |
| **Request Body** | DTO type or "none" |
| **Response** | `ApiResult<ResponseType>` |

### What It Does
Plain-language explanation of what this endpoint does when called.

### Parameters
| Name | Location | Type | Required | Description |
|------|----------|------|----------|-------------|
| `id` | Path | Long | Yes | The entity ID |

### Request Body (if applicable)
Description of what fields the request body expects and which are required.

### Response
Description of what the response contains.

### Error Cases
| Condition | HTTP Code | Error Message |
|-----------|-----------|---------------|

### Permissions Required
What abilities the user needs and where they're checked.

### Where It's Called From
Which frontend screens/actions trigger this endpoint.

## Important Rules
- **Include the full path** — class-level `@Path` + method-level `@Path`.
- **Note if the endpoint is deprecated** or has a newer replacement.
- If there are multiple endpoints matching the query, list all of them and let the user pick.
- **DO NOT suggest code changes.**
