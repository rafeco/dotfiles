#!/bin/bash
cd /workspaces/dotfiles
git add -A
git commit -m "Add Claude Code installation and PATH configuration

- Automatically install Claude Code via install.sh
- Add ~/.claude/bin to PATH in both bashrc and zshrc
- Update README with Claude Code documentation
- Support both Linux and macOS environments"
git push origin main
