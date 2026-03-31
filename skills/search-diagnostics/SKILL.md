---
title: Search Diagnostics
description: Investigate Elasticsearch/OpenSearch issues for Support
tags: [support, search, elasticsearch]
---

# Search Diagnostics

You are helping a **Product Support Specialist** investigate a search-related issue. Search issues are tricky because data lives in two places: MySQL (source of truth) and Elasticsearch (search index), and they can diverge.

## Input

The user will provide one or more of:
- "Record exists but doesn't show up in search"
- "Search shows outdated data"
- "Search returns 0 results for everyone"
- "Search returns wrong/unexpected results"
- A specific entity type and ID (e.g., "report 45678")
- A search query that isn't working as expected

## Workflow

### Step 1: Identify the Entity and Search Model
- Determine which entity type is affected (report, case, person, etc.)
- Find the corresponding `Elastic*.java` model
- Find the `*DataTranslator.java` that maps entity → Elastic model
- Note which fields are indexed and their types (keyword vs text)

### Step 2: Check the Search Query
- Find the search service/method that builds the Elasticsearch query
- Identify what filters are applied (department, status, date range, etc.)
- Check if the query uses `term` (exact match) vs `match` (full-text)
- Note any default filters that might exclude results (e.g., `is_deleted`)

### Step 3: Check the Sync Pipeline
- Find the `*SearchSyncService` or `*SyncService` for this entity
- Identify when sync happens (immediately after write? async? batch?)
- Check if there are known failure points (try/catch blocks, retry logic)
- Look for reindex methods

### Step 4: Compare DB Model vs. Elastic Model
- List fields that exist in the database entity but NOT in the Elastic model
- List any field type mismatches (e.g., field stored as keyword but user expects text search)
- Note if `isDeleted` / soft-delete filtering works differently between DB and ES

### Step 5: Identify the Root Cause Category
- **Sync failure**: Data written to DB but not synced to ES
- **Stale data**: ES has an older version of the record
- **Missing field**: The searched field isn't in the Elastic model
- **Wrong query type**: Using exact match on a field that needs full-text (or vice versa)
- **Department scoping**: User searching in wrong department context
- **Deleted records**: Soft-deleted in DB but not removed from ES index

## Output Format

### Search Issue Summary
One sentence: "The search for [entity type] is [not returning results / showing stale data / etc.] because [root cause]."

### How Search Works for This Entity
- **Database model**: entity name, table, key fields
- **Elastic model**: model name, indexed fields, field types
- **Sync trigger**: when does the index get updated
- **Sync method**: file and method name

### Field Comparison
| Field | In Database | In Elastic | Type | Searchable? |
|-------|:-----------:|:----------:|------|:-----------:|
| reportTitle | Yes | Yes | text | Full-text |
| reportNumber | Yes | Yes | keyword | Exact only |
| internalNotes | Yes | No | — | Not searchable |

### Root Cause
Explanation of why the search isn't working as expected.

### What to Check
- [ ] Steps for Support to verify
- [ ] Data to look up
- [ ] Whether a reindex is needed
- [ ] Whether to escalate to engineering

### Resolution Options
- If sync issue: recommend reindex (single record or department)
- If missing field: explain it's not searchable by design (or flag as feature gap)
- If query issue: explain how the search works and how to adjust the search terms

## Important Rules
- **Always check both the DB model and Elastic model** — the divergence is usually the answer.
- **Note field types** — keyword vs text is the most common source of confusion.
- **DO NOT suggest code changes.**
