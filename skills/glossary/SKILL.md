---
title: Glossary
description: Look up and explain Mark43 terminology and domain concepts
tags: [support, glossary, terminology]
---

# Glossary

You are helping a **Product Support Specialist** understand a term, concept, or piece of jargon from the Mark43 platform. This could be a technical term, a domain-specific concept, or an internal naming convention.

## Input

The user will provide:
- A term or phrase they don't understand
- Optionally, the context where they encountered it

## Workflow

### Step 1: Identify the Term Category
Classify the term:
- **Domain concept** (law enforcement / public safety terminology)
- **Mark43 platform concept** (product-specific terms)
- **Technical concept** (programming / infrastructure terms)
- **Abbreviation or acronym**

### Step 2: Find It in the Codebase
- Search for the term in code, comments, CLAUDE.md files, and documentation
- Find where it's defined, used, and referenced
- Check for related terms or synonyms

### Step 3: Build the Definition
Write a clear definition that includes:
- What it means in plain language
- How it's used in Mark43 specifically
- Why Support should care about it
- Related terms

## Output Format

### [Term]

**Plain-language definition**: One sentence explanation anyone can understand.

**In Mark43 context**: How this concept specifically applies to the Mark43 platform.

**Why it matters for Support**: When would you encounter this and why does it matter for troubleshooting?

**Where you'll see it**: Code, UI, logs, customer conversations, etc.

**Related terms**: Other terms often used alongside this one.

**Example**: A concrete example using Mark43 data.

## Built-In Reference

When the user asks about common terms, draw from this reference AND verify against the current codebase:

### Platform Concepts
- **Department**: A Mark43 tenant — each customer agency is a department. Data is isolated between departments. NOT the same as a police division/unit.
- **Abilities / Permissions**: Feature-level access controls assigned to user roles. Checked on both frontend and backend.
- **Soft Delete**: Records aren't removed from the database — they're marked `is_deleted = true` and filtered from queries. The data is preserved for audit/compliance.
- **Department Scoping**: All data queries are filtered by department ID so users only see their own agency's data.
- **Search Sync**: The process of copying data from MySQL to Elasticsearch so it's searchable. Can fail or lag.
- **Feature Flag**: A toggle that enables/disables functionality per department or globally.
- **Sealed**: A report state that permanently locks it from editing. Cannot be reversed.
- **Reindex**: Rebuilding the Elasticsearch index from the database source of truth.

### Technical Concepts
- **Entity**: A Java class that maps to a database table row.
- **DTO / Request / Response**: Data Transfer Objects — the shape of data sent between frontend and backend.
- **Repository**: Code that reads/writes data to the database.
- **Service**: Code that contains business logic (validation, permissions, coordination).
- **Resource / Controller**: Code that handles incoming HTTP requests (the API layer).
- **Migration**: A versioned script that changes the database schema.
- **Flyway**: The tool that runs database migrations in order.
- **Translator / Mapper**: Code that converts between entity and DTO formats.

### Law Enforcement / Public Safety Terms
- **RMS**: Records Management System — for managing reports, cases, people, property.
- **CAD**: Computer-Aided Dispatch — for 911 dispatch operations.
- **JMS**: Jail Management System — for booking and detainee management.
- **CJIS**: Criminal Justice Information Services — FBI security policy that governs how criminal justice data must be handled.
- **PII**: Personally Identifiable Information — must be handled with extra care (logging restrictions, access controls).
- **UCR / NIBRS**: Uniform Crime Reporting / National Incident-Based Reporting System — FBI crime statistics standards.
- **Chain of Custody**: Documented trail of who handled evidence and when.

## Important Rules
- **Plain language first.** If someone is asking what a term means, they don't need a technical deep-dive.
- **Connect to Support work.** Always explain why the term matters for troubleshooting.
- **Verify in code** when possible — terms can have specific meanings in Mark43 that differ from general usage.
- **DO NOT suggest code changes.**
