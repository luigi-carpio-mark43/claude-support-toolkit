# Claude Support Toolkit

Claude Code configuration and skills for Mark43 **Product Support** personnel. These tools help Support investigate issues, trace errors, understand features, and look up permissions — all without needing to be a software engineer.

## What's Included

### Global CLAUDE.md
Sets the ground rules for how Claude Code behaves for Support:
- Explains things in plain language, not engineer-speak
- Investigates issues instead of suggesting code changes
- Traces from UI to database when diagnosing problems
- Always surfaces permissions, config, and "what to check" steps

### Support Skills

| Skill | What It Does |
|-------|-------------|
| `/investigate` | Trace a customer-reported symptom through the code |
| `/explain-feature` | Plain-language explanation of how a feature works end-to-end |
| `/check-permissions` | Look up which abilities/permissions gate a feature |
| `/trace-error` | Decode an error message or stack trace into plain English |
| `/find-config` | Find feature flags and department settings that affect behavior |
| `/api-lookup` | Find a REST endpoint and explain what it does |
| `/data-flow` | Trace data from UI field through API to database and back |
| `/recent-changes` | Check git history for "this was working before" investigations |
| `/known-limitations` | Search for TODOs, FIXMEs, and documented limitations |
| `/support-brief` | Generate a shareable, KB-ready summary of a feature |

## Setup

### Quick Install (Bash)

From the root of this repo, run:

```bash
./install.sh
```

This copies the CLAUDE.md and skills to your `~/.claude/` directory.

### Manual Install

1. Copy `CLAUDE.md` to `~/.claude/CLAUDE.md`:
   ```bash
   cp CLAUDE.md ~/.claude/CLAUDE.md
   ```

2. Copy the skills directory to `~/.claude/skills/`:
   ```bash
   cp -r skills/* ~/.claude/skills/
   ```

> **Note:** If you already have a `~/.claude/CLAUDE.md`, the install script will back it up before overwriting.

## Usage

Once installed, open Claude Code in any of the Mark43 repos (`mark43`, `rms`, etc.) and use the skills:

```
/investigate customer reports 403 when trying to approve a report
/check-permissions report approval
/trace-error "User does not have required ability: APPROVE_REPORTS"
/explain-feature case merging
/recent-changes report approval --since last week
```

## Updating

Pull the latest from this repo and re-run `./install.sh`.

## Contributing

If you have ideas for new skills or improvements to existing ones, open a PR! Good candidates for new skills:
- Patterns you find yourself investigating repeatedly
- Troubleshooting workflows you've documented for the team
- Feature areas that are frequently asked about
