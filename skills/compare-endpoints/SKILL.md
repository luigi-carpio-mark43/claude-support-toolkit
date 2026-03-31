---
title: Compare Endpoints
description: Compare how a feature is implemented across different Mark43 repos
tags: [support, comparison, cross-repo]
---

# Compare Endpoints

You are helping a **Product Support Specialist** understand how the same or similar feature is implemented differently across Mark43 repos (RMS, CAD, JMS, security-alerts). This is useful when a feature works in one product but not another, or when troubleshooting steps differ by product.

## Input

The user will provide:
- A feature name (e.g., "case search", "report approval", "permissions check")
- Which repos to compare (e.g., "RMS vs CAD", "RMS vs JMS")
- Optionally, a specific behavior difference they've noticed

## Workflow

### Step 1: Find the Feature in Each Repo
For each repo specified:
- Locate the relevant endpoint/resolver/controller
- Find the service layer handling business logic
- Identify the permissions/abilities required
- Note the data model and storage

### Step 2: Compare Architecture Patterns
Note the fundamental differences:

| Aspect | RMS / CAD | JMS | Security-Alerts |
|--------|-----------|-----|-----------------|
| API style | REST (JAX-RS) | GraphQL | REST (Spring MVC) |
| DI framework | Guice | Spring | Spring |
| Permission pattern | @AbilitiesAllowed | @PreAuthorize | @Authorization |
| Frontend state | Redux / MobX | Apollo Client | TanStack Query |

### Step 3: Compare the Specific Feature
For the feature being investigated:
- How is it accessed? (endpoint path, GraphQL query, etc.)
- What permissions are needed?
- What validation is applied?
- What data is stored and where?
- How does error handling work?
- Are there feature flags or config differences?

### Step 4: Highlight Support-Relevant Differences
Focus on differences that affect troubleshooting:
- Different permission names for the same feature
- Different error messages for the same situation
- Different configuration or feature flag requirements
- Different data storage or sync behavior

## Output Format

### Comparison Summary
One paragraph: "The [feature] exists in [repos]. The key differences are [summary]."

### Side-by-Side Comparison
| Aspect | Repo A | Repo B |
|--------|--------|--------|
| Endpoint | `PUT /api/rms/reports/{id}/approve` | `mutation approveReport(id)` |
| Permission | `APPROVE_REPORTS` via `@AbilitiesAllowed` | `APPROVE_REPORTS` via `@PreAuthorize` |
| Validation | Must be in DRAFT status | Must be in SUBMITTED status |
| Error message | "Report must be in DRAFT status" | "Cannot approve: invalid status" |
| Frontend check | Redux selector | Apollo cache |

### Support Implications
For each significant difference:
- How does it affect troubleshooting?
- Are the same support steps applicable, or do they differ?
- Are there features that exist in one repo but not the other?

### Troubleshooting Guide by Product
Brief checklist for each product:
- **In RMS**: check X, then Y, then Z
- **In JMS**: check A, then B, then C

## Important Rules
- **Always specify which repo you're looking at** — don't mix code from different repos.
- **Focus on support-relevant differences**, not engineering details.
- **Note when a feature doesn't exist** in one of the repos.
- **DO NOT suggest code changes.**
