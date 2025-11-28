#!/bin/bash
cd /workspaces/dotfiles
git add -A
git commit -m "Fix Claude Code PATH: support both ~/.claude/bin and ~/.local/bin

- Claude Code installs to ~/.local/bin on macOS
- Claude Code installs to ~/.claude/bin on Linux/Codespaces
- Update bashrc and zshrc to check both locations"
git push origin main
