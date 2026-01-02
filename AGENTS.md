# Guide for AI Coding Agents

This document provides guidance for AI coding agents (like Claude Code) working on this dotfiles repository. For architectural details and patterns, see [.claude/context.md](.claude/context.md).

## Repository Overview

This is a personal dotfiles repository for managing development environment configuration across macOS, Linux, WSL (Windows Subsystem for Linux), GitHub Codespaces, and Dev Containers. It includes configurations for Git, Bash, Zsh, tmux, Vim, and VS Code, with features like:

- Python virtual environment management (`venv` command)
- GitHub account switching (`gh-setup` and dynamic `gh-{name}` commands)
- Package management for macOS (Homebrew) and Ubuntu/Debian (APT)
- VS Code integration with platform-specific handling (WSL, Dev Containers)
- Cross-platform compatibility with sensible defaults

## Commit Conventions

### Commit Message Style

Based on the repository's git history, follow these patterns:

**Summary Line:**
- Use imperative mood: "Add...", "Fix...", "Make...", "Improve...", "Refactor..."
- Be specific and descriptive
- No period at the end
- Examples:
  - `Add Starship prompt support with fallback to custom prompts`
  - `Fix gh-setup compatibility with bash 3.2 (macOS default)`
  - `Make GitHub account switcher config-driven and extensible`

**Description:**
- Leave a blank line after the summary
- Explain **what** changed and **why**
- Use bullet points for multiple changes
- Include context about benefits, trade-offs, or migration notes when relevant
- Mention affected files or features when helpful

**Footer:**
- Include Claude Code co-authorship when appropriate:
  ```
  🤖 Generated with [Claude Code](https://claude.com/claude-code)

  Co-Authored-By: Claude <noreply@anthropic.com>
  ```

**Example:**
```
Make GitHub account switcher config-driven and extensible

Refactor gh-* commands to support unlimited accounts with dynamic
function generation. Move gh-setup to standalone bash script to
avoid shell compatibility issues.

Changes:
- Replace shell variable format with git config (INI) format
- Dynamically generate gh-{name} functions at shell startup
- Move gh-setup to standalone bash script (home/gh-setup)
- Config file at ~/.gh-accounts uses familiar gitconfig syntax

Benefits:
- Support for unlimited accounts (personal, work, consulting, etc.)
- Easy to add/remove accounts via interactive wizard
- Familiar INI syntax that users already know from gitconfig

Migration: Existing ~/.gh-accounts files need to be recreated with
gh-setup or manually converted to the new INI format.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### Commit Size

Commits should be **focused but complete**—one logical change per commit, fully implemented:

- **Small commits** (1-2 files, ~10-50 lines)
  - Documentation updates
  - Small bug fixes
  - Minor configuration tweaks
  - Example: "Moved 'key features' to the top"

- **Medium commits** (2-4 files, ~50-250 lines)
  - New features
  - Refactoring existing code
  - Moderate enhancements
  - Example: "Add venv helper function for Python virtual environment management"

- **Large commits** (4-5 files, 250-1400+ lines)
  - Major new features
  - Comprehensive documentation additions
  - Significant refactors
  - Example: "Add comprehensive documentation to all config files" (5 files, 1408 insertions)

Don't artificially split coherent changes just to keep commits small. A complete feature is better than a fragmented one.

## Working with This Repository

### Before Making Changes

1. **Read the architecture docs**: Review `.claude/context.md` to understand patterns
2. **Check both shell configs**: When modifying shell functions, update both `home/bashrc` and `home/zshrc`
3. **Understand the .local pattern**: Never commit personal information; use `.gitconfig.local`, `.bashrc.local`, etc.
4. **Review existing code**: Read files before modifying them to understand existing patterns

### Common Workflows

#### Adding a Shell Function

1. Add to `home/bashrc` with bash-compatible syntax
2. Add the same function to `home/zshrc` (adjust syntax only if needed for zsh)
3. Keep functions in sync between both files
4. Test syntax: `bash -n home/bashrc && zsh -n home/zshrc`
5. Update README.md if it's a user-facing feature

#### Adding Git Configuration

- **Universal settings**: Add to `home/gitconfig`
- **Platform-specific**: Add to `platform/gitconfig.{macos,linux,codespaces}`
- **Never hardcode**: Personal info like name/email (document the `.gitconfig.local` pattern instead)

#### Adding Files with Personal Data

1. Add the file pattern to `.gitignore`
2. Include a comment explaining why (e.g., `# Contains personal information`)
3. Provide an example template if helpful (e.g., `home/gh-accounts.example`)

#### Working with VS Code and Platform Detection

- **vscode-install.sh**: Handles platform detection for WSL, macOS, and Linux
- **WSL detection**: Uses `/proc/version` check and finds Windows user directory
- **Key difference**: WSL copies files (not symlinks) to work across file system boundary
- **Dev containers**: Extensions managed in `.devcontainer/devcontainer.json`
- **Testing**: Run the installer on each platform to verify detection and installation

### Testing Changes

Always test before committing:

```bash
# Syntax check shell configs
bash -n home/bashrc
zsh -n home/zshrc

# Test in actual shells
bash -c 'source home/bashrc && function-name'
zsh -c 'source home/zshrc && function-name'

# Verify git config syntax
git config -f home/gitconfig --list
```

### Documentation Standards

- **README.md**: User-focused, feature explanations, quick start
- **.claude/context.md**: Technical architecture, patterns, conventions
- **Inline comments**: Explain complex logic or non-obvious decisions
- **Config file comments**: Comprehensive explanations in dotfiles (see existing files for examples)

## Key Principles

1. **Cross-platform compatibility**: Test or consider macOS, Linux, WSL, Codespaces, and Dev Containers
2. **Keep bash and zsh in sync**: Maintain feature parity, differ only for shell-specific syntax
3. **Platform-specific handling**: Use detection (e.g., `$OSTYPE`, `/proc/version`) to adapt behavior
4. **Privacy by default**: Never commit personal information, use `.local` files
5. **Sensible defaults**: Configuration should work out-of-the-box for most users
6. **No over-engineering**: Add only what's requested or clearly necessary
7. **User feedback**: Shell functions and scripts should provide clear success/error messages

## Anti-Patterns to Avoid

- **Don't** hardcode personal information in tracked files
- **Don't** add to only one shell config (bash or zsh)—keep them in sync
- **Don't** skip testing in both bash and zsh before committing
- **Don't** create overly complex abstractions for simple tasks
- **Don't** add backwards-compatibility hacks for removed features
- **Don't** commit files without proper .gitignore entries if they contain personal data

## When in Doubt

1. Check existing code for patterns to follow
2. Review `.claude/context.md` for architectural guidance
3. Look at recent commits for style and scope examples
4. Ask the user if the approach isn't clear
5. Prefer simplicity over cleverness

## Quick Reference

**File organization:**
- `home/*` → Symlinked to `~/.*` (dotfiles)
- `platform/*` → Platform-specific configs
- `.claude/*` → Claude Code settings and context
- `.devcontainer/*` → Dev container configuration
- `vscode/*` → VS Code settings and extensions
- Base directory → Setup scripts and installers

**Key files:**
- `home/bashrc`, `home/zshrc` → Shell configs (keep in sync)
- `home/gitconfig` → Universal git config
- `home/shell_functions` → Shared shell functions (sourced by both shells)
- `install.sh` → Main dotfiles installer (creates symlinks)
- `brew-setup` → macOS package installer (Homebrew)
- `ubuntu-setup` → Ubuntu/Debian package installer (APT)
- `vscode-install.sh` → VS Code settings installer (handles WSL, macOS, Linux)

**Testing:**
- Syntax: `bash -n FILE` or `zsh -n FILE`
- Git config: `git config -f FILE --list`
- Function test: `bash -c 'source FILE && function-name'`

For detailed architecture information, patterns, and examples, see [.claude/context.md](.claude/context.md).
