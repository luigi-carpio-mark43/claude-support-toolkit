#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Support Toolkit Installer ==="
echo ""

# Ensure ~/.claude exists
mkdir -p "$CLAUDE_DIR"
mkdir -p "$CLAUDE_DIR/skills"

# Back up existing CLAUDE.md if present
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    BACKUP="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing CLAUDE.md to $BACKUP"
    cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP"
fi

# Copy CLAUDE.md
echo "Installing CLAUDE.md..."
cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Copy skills
echo "Installing skills..."
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$CLAUDE_DIR/skills/$skill_name"
    cp "$skill_dir"* "$CLAUDE_DIR/skills/$skill_name/"
    echo "  - $skill_name"
done

echo ""
echo "Done! Installed:"
echo "  - CLAUDE.md -> ~/.claude/CLAUDE.md"
echo "  - $(ls -d "$SCRIPT_DIR/skills"/*/ | wc -l) skills -> ~/.claude/skills/"
echo ""
echo "Open Claude Code in a Mark43 repo and try: /investigate <your issue>"
