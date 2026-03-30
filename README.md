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
| `/api-lookup` | Find a REST endpoint and explain what it does |
| `/check-permissions` | Look up which abilities/permissions gate a feature |
| `/data-flow` | Trace data from UI field through API to database and back |
| `/explain-feature` | Plain-language explanation of how a feature works end-to-end |
| `/find-config` | Find feature flags and department settings that affect behavior |
| `/investigate` | Trace a customer-reported symptom through the code |
| `/known-limitations` | Search for TODOs, FIXMEs, and documented limitations |
| `/recent-changes` | Check git history for "this was working before" investigations |
| `/support-brief` | Generate a shareable, KB-ready summary of a feature |
| `/trace-error` | Decode an error message or stack trace into plain English |

## Prerequisites

- [Claude Code](https://claude.ai/claude-code) installed and authenticated
- Git (for cloning this repo)
- Access to the Mark43 `mark43` and/or `rms` repositories

## Setup

### Windows (PowerShell)

Most of the team uses Windows. From the root of this repo, run:

```powershell
.\install.ps1
```

> If you get an execution policy error, run this first:
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

### macOS / Linux (Bash)

```bash
./install.sh
```

Both scripts copy the CLAUDE.md and skills into your `~/.claude/` directory (`%USERPROFILE%\.claude\` on Windows).

> **Note:** If you already have a `~/.claude/CLAUDE.md`, the install script will back it up before overwriting.

### Manual Install

<details>
<summary>Windows (PowerShell)</summary>

```powershell
# Back up existing CLAUDE.md if you have one
Copy-Item "$env:USERPROFILE\.claude\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md.backup" -ErrorAction SilentlyContinue

# Copy CLAUDE.md
Copy-Item CLAUDE.md "$env:USERPROFILE\.claude\CLAUDE.md" -Force

# Copy skills
Copy-Item -Recurse -Force skills\* "$env:USERPROFILE\.claude\skills\"
```

</details>

<details>
<summary>macOS / Linux (Bash)</summary>

```bash
# Back up existing CLAUDE.md if you have one
cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup 2>/dev/null

# Copy CLAUDE.md
cp CLAUDE.md ~/.claude/CLAUDE.md

# Copy skills
cp -r skills/* ~/.claude/skills/
```

</details>

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

Pull the latest from this repo and re-run the install script:

```powershell
git pull
.\install.ps1        # Windows
```
```bash
git pull
./install.sh         # macOS / Linux
```

## Contributing

If you have ideas for new skills or improvements to existing ones, open a PR! Good candidates for new skills:
- Patterns you find yourself investigating repeatedly
- Troubleshooting workflows you've documented for the team
- Feature areas that are frequently asked about
