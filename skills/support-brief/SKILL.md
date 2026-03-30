---
title: Support Brief
description: Generate a concise, support-friendly summary of a feature area
tags: [support, documentation, brief]
---

# Support Brief

You are helping a **Product Support Specialist** create a clear, shareable summary of a feature area. The output should be suitable for sharing with other Support team members or adding to an internal knowledge base.

## Input

The user will provide:
- A feature name or area to document
- Optionally, a specific angle (e.g., "focus on the permissions side", "for training new team members")

## Workflow

### Step 1: Research the Feature Thoroughly
Using the codebase, gather information about:
- What the feature does (frontend components, user interactions)
- How it works (API endpoints, services, data storage)
- What permissions are needed
- What configuration affects it
- Known limitations or quirks
- Common error scenarios

### Step 2: Write for a Support Audience
- Use plain language — no unexplained technical jargon
- Focus on what Support needs to know to help customers
- Structure for quick reference (scannable headers, bullet points, tables)
- Include troubleshooting guidance

## Output Format

---

# [Feature Name] — Support Brief

## What It Does
2-3 sentences explaining the feature from the customer's perspective. What problem does it solve? Where do they find it in the product?

## How It Works (Simplified)
Numbered steps of the basic flow, from user action to result. Keep this high-level — the audience doesn't need to know about Java services.

## Permissions Required
| Ability | What It Controls |
|---------|-----------------|
| `ABILITY_NAME` | What the user can do with this ability |

**Note:** List minimum permissions for basic use, then extras for admin/advanced features.

## Key Settings & Configuration
| Setting | What It Does | Default | Who Can Change It |
|---------|-------------|---------|-------------------|

## Common Issues & Troubleshooting

### "Customer can't see/access [feature]"
- Check: [permission]
- Check: [config/flag]
- Check: [department setting]

### "Customer gets an error when..."
- Common cause: [explanation]
- Check: [what to verify]

### "[Feature] shows wrong data / missing data"
- Common cause: [explanation]
- Check: [what to verify]

## Known Limitations
- Bullet list of things the feature doesn't support or known quirks

## Related Features
Links/references to related features that often come up together.

## Code References (For Deeper Investigation)
| Area | Key File | Purpose |
|------|----------|---------|
| Frontend | `path/to/component` | Main UI component |
| API | `path/to/Resource.java` | REST endpoint |
| Service | `path/to/Service.java` | Business logic |

---

## Important Rules
- **Write for Support, not for engineers.** This should be immediately useful to someone handling a customer call.
- **Be accurate.** Verify claims by reading the code. Don't guess about permissions or config.
- **Be concise.** This is a quick-reference brief, not a design document.
- **Include actionable troubleshooting** — the most valuable part for Support is "what to check when X happens."
- **DO NOT include code snippets.** Use file references instead.
- The output should be **copy-pasteable** into a knowledge base or shared document.
