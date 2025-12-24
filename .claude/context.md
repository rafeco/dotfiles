# Dotfiles Architecture

This document describes the structure, patterns, and conventions used in this dotfiles repository. It's intended to help Claude Code and contributors quickly understand how to work with the codebase.

## Repository Structure

### Directory Layout
- `home/` - Configuration files that get symlinked to `~/.*`
- `platform/` - Platform-specific configuration overrides
- `.claude/` - Claude Code settings and context documentation
- Root files: `install.sh`, `bootstrap.sh`, `README.md`, `.gitignore`

### Key Files
- `install.sh` - Main installation script that creates symlinks and detects platform
- `bootstrap.sh` - One-line installer wrapper (downloads and runs install.sh)
- `home/bashrc` - Bash shell configuration
- `home/zshrc` - Zsh shell configuration
- `home/gitconfig` - Git configuration with includes for platform and local overrides
- `home/tmux.conf` - tmux terminal multiplexer configuration
- `home/vimrc` - Vim text editor configuration
- `platform/gitconfig.{macos,linux,codespaces}` - Platform-specific git configs

## Patterns and Conventions

### The .local Pattern
Configuration files support `.local` overrides that are never tracked in git. This allows users to customize settings without modifying tracked files.

Files that support `.local` overrides:
- `~/.gitconfig.local` - Personal git settings (name, email, aliases)
- `~/.bashrc.local` - Personal bash settings
- `~/.zshrc.local` - Personal zsh settings
- `.claude/settings.local.json` - Personal Claude Code settings

The main config files include these `.local` files if they exist:
```bash
# Example from bashrc/zshrc
if [ -f "$HOME/.bashrc.local" ]; then
  source "$HOME/.bashrc.local"
fi
```

### Platform Detection
Configurations automatically adapt to the runtime environment:
- **macOS** (detected via `$OSTYPE == "darwin"*`)
- **Linux**
- **GitHub Codespaces** (detected via `$CODESPACES == "true"`)

Platform-specific settings are stored in `platform/` directory and symlinked during installation.

### Shell Function Conventions
Functions in `bashrc` and `zshrc` follow consistent patterns:

**Naming:**
- Lowercase with hyphens (e.g., `gh-setup`, `gh-work`, `mkcd`)
- Descriptive names that indicate purpose

**Implementation:**
- Same functions defined in both `bashrc` and `zshrc`
- Bash uses bash-specific syntax (`read -e -p`)
- Zsh uses zsh-specific syntax where needed (`vared -p`)
- Section header comments group related functions
- Check prerequisites before executing
- Provide user feedback (success/error messages)

**Example pattern:**
```bash
# Section header comment
function-name() {
  # Check prerequisites
  if [[ ! -f ~/.config ]]; then
    echo "⚠ Error message"
    return 1
  fi

  # Do work
  command --flag value
  echo "✓ Success message"
}
```

### Git Configuration Pattern
Git configuration uses a layered include system:

1. **Base config** (`home/gitconfig`) - Universal settings for all platforms
2. **Platform config** (`~/.gitconfig.platform`) - Platform-specific (credential helpers, etc.)
3. **Local overrides** (`~/.gitconfig.local`) - Personal settings never tracked in git

```gitconfig
# In home/gitconfig
[include]
  path = ~/.gitconfig.platform
  path = ~/.gitconfig.local
```

### Configuration File Patterns

**Reading config files:**
```bash
if [[ -f ~/.config-file ]]; then
  source ~/.config-file
fi
```

**Writing config files:**
```bash
cat > ~/.config-file <<EOF
KEY=value
KEY2=value2
EOF
```

**Interactive prompts (bash):**
```bash
read -e -p "Prompt: " -i "$DEFAULT_VALUE" variable
```

**Interactive prompts (zsh):**
```zsh
variable="${DEFAULT_VALUE}"
vared -p "Prompt: " variable
```

## How to Add New Features

### Adding Shell Functions

1. **Add to bashrc** (`home/bashrc`)
   - Insert after existing functions in the appropriate section
   - Use bash-compatible syntax

2. **Add to zshrc** (`home/zshrc`)
   - Add the same function in the same location
   - Adjust syntax for zsh if needed (e.g., `vared` instead of `read -e`)

3. **Use section headers**
   - Group related functions with comments (e.g., `# GitHub account switching`)

4. **Keep files in sync**
   - Maintain feature parity between bash and zsh
   - Only differ when shell-specific syntax is required

5. **Test both shells**
   - Verify syntax: `bash -n home/bashrc`
   - Verify syntax: `zsh -n home/zshrc`
   - Test functionality in both shells

### Adding Git Configuration

**For universal settings:**
- Add to `home/gitconfig` in the appropriate section
- These apply to all platforms

**For platform-specific settings:**
- Add to `platform/gitconfig.macos`, `platform/gitconfig.linux`, or `platform/gitconfig.codespaces`
- Example: credential helpers, diff tools

**For personal settings:**
- Never hardcode personal info (name, email) in tracked files
- Document the `.gitconfig.local` pattern for users
- Example in documentation or setup scripts

### Adding to .gitignore

- Add files that contain personal or sensitive information
- Add local-only config files (`*.local`, etc.)
- Group related entries with descriptive comments
- Example:
  ```gitignore
  # GitHub account switcher config (contains personal info)
  .gh-accounts
  ```

### Installation Process

Understanding the installation flow helps when adding new features:

1. **bootstrap.sh** - Downloads dotfiles and runs install.sh
2. **install.sh** - Main installation logic:
   - Creates `~/.dotfiles_backup_*` directory for existing files
   - Symlinks all `home/*` files to `~/.*`
   - Detects platform (macOS/Linux/Codespaces)
   - Symlinks appropriate `platform/gitconfig.*` to `~/.gitconfig.platform`
   - Installs Claude Code if not present
   - Sets proper permissions

## Common Tasks

### To add a new shell alias
Edit `home/bashrc` and `home/zshrc` in the aliases section (search for `# Better df output` or similar section headers)

### To add a new git alias
Edit `home/gitconfig` in the `[alias]` section

### To add platform-specific behavior
Add to the appropriate `platform/gitconfig.{platform}` file

### To ignore a file from git
Add to `.gitignore` with a descriptive comment explaining why

### To add a new utility function
Add to both `home/bashrc` and `home/zshrc`, following the shell function conventions above

## File Locations After Installation

**Symlinks created by installer:**
- `~/.bashrc` → `~/.dotfiles/home/bashrc`
- `~/.zshrc` → `~/.dotfiles/home/zshrc`
- `~/.gitconfig` → `~/.dotfiles/home/gitconfig`
- `~/.gitconfig.platform` → `~/.dotfiles/platform/gitconfig.{platform}`
- `~/.tmux.conf` → `~/.dotfiles/home/tmux.conf`
- `~/.vimrc` → `~/.dotfiles/home/vimrc`

**Local files (NOT symlinked, created by user or scripts):**
- `~/.gitconfig.local` - Personal git overrides
- `~/.bashrc.local` - Personal bash overrides
- `~/.zshrc.local` - Personal zsh overrides
- `~/.gh-accounts` - GitHub account switcher config (if using gh-work/gh-personal)

## Examples from This Repository

### GitHub Account Switcher
Located in `home/bashrc` and `home/zshrc`, this feature demonstrates:
- Shell function conventions (gh-setup, gh-work, gh-personal, gh-whoami)
- Configuration file patterns (reading/writing ~/.gh-accounts)
- Bash vs zsh syntax differences (read -e vs vared)
- User feedback patterns (✓ success, ⚠ warnings)
- Gitignore usage (.gh-accounts excluded to protect personal info)

### Platform Detection for Git
Located in `platform/gitconfig.*`, this demonstrates:
- Platform-specific configuration
- Include pattern from main gitconfig
- Credential helper selection per platform

## Tips for Claude Code

When working in this repository:

1. **Check both bashrc and zshrc** when modifying shell functions
2. **Never commit personal information** - use the .local pattern
3. **Test syntax** with `bash -n` and `zsh -n` before committing
4. **Follow existing patterns** for consistency
5. **Update .gitignore** when adding config files with personal data
6. **Keep README.md user-focused** - this file is for technical details
