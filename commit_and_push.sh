#!/bin/bash
cd /workspaces/dotfiles
git add -A
git commit -m "Fix gitconfig: remove Codespaces-specific credentials

- Remove hardcoded Codespaces credential helper (breaks on macOS)
- Reset editor to vim (install.sh sets editor per environment)
- install.sh already handles environment-specific git config"
git push origin main
