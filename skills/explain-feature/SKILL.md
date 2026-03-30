---
title: Explain Feature
description: Explain how a Mark43 feature works end-to-end for Support
tags: [support, feature, explanation]
---

# Explain Feature

You are helping a **Product Support Specialist** understand how a feature works. They need a clear, plain-language explanation suitable for someone who reads code but doesn't write it.

## Input

The user will provide:
- A feature name (e.g., "case merging", "report duplication", "warrant search")
- Optionally, a specific aspect they want to understand

## Workflow

### Step 1: Locate the Feature
- Search the codebase for the feature by name, keywords, and related terms
- Identify all relevant code across frontend, backend, and data layers
- Check CLAUDE.md files for existing documentation on this feature

### Step 2: Map the Feature End-to-End
Trace the complete flow:
1. **User Interface**: Where does the user interact with this? What screen, what actions?
2. **Frontend Logic**: What happens when the user acts? State management, validation, API calls.
3. **API Layer**: Which endpoints are involved? What data goes back and forth?
4. **Business Logic**: What does the service layer do? Rules, validation, transformations.
5. **Data Storage**: What tables/entities are involved? What gets written/read?
6. **Search/Indexing**: Is Elasticsearch involved? What's searchable?

### Step 3: Identify the Support-Relevant Details
- **Permissions**: What abilities does a user need?
- **Configuration**: What feature flags or department config affects this?
- **Edge Cases**: What are the known limitations or special behaviors?
- **Error Scenarios**: What errors can the user hit and what do they mean?
- **Dependencies**: What other features or data must exist first?

## Output Format

### What It Does
2-3 sentences explaining the feature in plain language. What problem does it solve for the end user?

### How It Works
Step-by-step walkthrough of the normal flow, from user action to system response. Use numbered steps. Keep it non-technical but accurate.

### Permissions Required
Table of abilities needed:
| Ability | What It Grants | Required For |
|---------|---------------|-------------|

### Configuration & Feature Flags
List any settings that affect this feature's behavior, with what each option does.

### Key Limitations & Edge Cases
Bullet list of things Support should know — behaviors that surprise users, known quirks, unsupported scenarios.

### Common Support Scenarios
Brief FAQ-style list:
- "Customer says X" -> Here's what's probably happening
- "User can't do Y" -> Check these permissions/settings

### Code References
List of key files for deeper investigation, with brief descriptions of what each does.

## Important Rules
- **Plain language first**, code references second.
- **DO NOT suggest code changes.**
- If the feature spans both `mark43` and `rms` repos, explain both sides.
- If you can't find the feature, say so and suggest alternative search terms.
