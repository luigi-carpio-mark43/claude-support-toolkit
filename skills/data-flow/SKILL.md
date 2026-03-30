---
title: Data Flow
description: Trace the full data flow for an operation from UI to database and back
tags: [support, data-flow, architecture]
---

# Data Flow

You are helping a **Product Support Specialist** understand how data moves through the system for a specific user action. This helps them understand where data could be lost, transformed, or blocked.

## Input

The user will provide:
- An operation (e.g., "creating a report", "searching cases", "approving an arrest")
- Optionally, a specific data point they're tracking (e.g., "where does the arrest date get stored?")

## Workflow

### Step 1: Start at the UI
- Find the React component where the user initiates the action
- Identify the form fields or inputs involved
- Trace the submit/action handler
- Note any frontend validation or transformation

### Step 2: Follow the API Request
- Identify the API call (endpoint, method, request body)
- Map frontend field names to the request DTO fields
- Note any data transformation between UI state and the request payload

### Step 3: Trace Through the Backend
- **Resource layer**: How is the request received? What annotations/validation?
- **Service layer**: What business logic is applied? Transformations? Enrichment?
- **Repository layer**: What gets written to the database? Which tables?
- **Search sync**: Does data get indexed in Elasticsearch? What fields?
- **Events/messaging**: Are any RabbitMQ events published?

### Step 4: Trace the Response
- What data comes back from the database/service?
- How is the response DTO constructed?
- What does the frontend do with the response?

### Step 5: Identify Transformation Points
Document every place where data is:
- **Validated** (could be rejected)
- **Transformed** (format change, enrichment, mapping)
- **Split** (written to multiple tables/indexes)
- **Filtered** (removed based on permissions or config)

## Output Format

### Flow Summary
One paragraph: "When a user [does X], the data flows through [N] layers: [brief description]."

### Step-by-Step Flow

**1. User Action (Frontend)**
- Component: `ComponentName` (file:line)
- User provides: [list of fields/inputs]
- Frontend validation: [what's checked]

**2. API Request**
- Endpoint: `METHOD /api/path`
- Request DTO: `DtoName` (file:line)
- Key fields: [mapped from UI]

**3. Business Logic (Service)**
- Service: `ServiceName.method` (file:line)
- Operations: [what happens to the data]
- Permission checks: [abilities checked]

**4. Data Storage (Repository/DB)**
- Table(s): `table_name`
- Key columns: [what's stored]
- Repository: `RepoName` (file:line)

**5. Search Indexing (if applicable)**
- Elastic model: `ElasticEntityName`
- Indexed fields: [what becomes searchable]

**6. Response Back to UI**
- Response DTO: `DtoName`
- What the user sees: [description]

### Data Mapping Table
| UI Field | Request DTO Field | DB Column | Elastic Field |
|----------|------------------|-----------|---------------|
| "Report Date" | `reportDate` | `report_date_utc` | `reportDateUtc` |

### Where Data Could Be Lost or Changed
Bullet list of transformation points where something could go wrong (validation rejection, null handling, timezone conversion, etc.)

## Important Rules
- **Follow the data, not the code structure.** The user cares about where their data goes.
- **Include field/column name mappings** — they're crucial for debugging data discrepancies.
- **Note timezone handling** — a common source of support issues.
- **Note department scoping** — data is often filtered by department.
- **DO NOT suggest code changes.**
