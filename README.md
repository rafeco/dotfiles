# dotfiles

This is my development environment. There are many like it, but this one is mine.

Modern dotfiles for Git, Bash, Zsh, tmux, Vim, and VS Code. Works on macOS (with Homebrew), Linux, WSL (Windows Subsystem for Linux), and GitHub Codespaces.

## Table of Contents

- [Key Features](#key-features)
- [Supported Platforms](#supported-platforms)
- [Quick Start](#quick-start)
- [Requirements](#requirements)
- [Core Configuration](#core-configuration)
  - [Shell - Bash & Zsh](#shell---bash--zsh)
  - [Git](#git)
  - [tmux](#tmux)
  - [Vim](#vim)
- [Optional Setup](#optional-setup)
  - [Package Management](#package-management)
  - [VS Code Integration](#vs-code-integration)
  - [Claude Code](#claude-code)
  - [Starship Prompt](#starship-prompt)
- [Advanced Features](#advanced-features)
  - [Python Virtual Environments](#python-virtual-environments)
  - [GitHub Account Switching](#github-account-switching)
- [Customization](#customization)
- [License](#license)

## Key Features

- **Easy Python virtual environment management** - One `venv` command to activate, deactivate, or create `.venv` directories
- **Seamless GitHub account switching** - Manage unlimited GitHub accounts with `gh-setup`, switch between them instantly with `gh-{name}` commands
- **Works with both Bash and Zsh** - Identical feature set and shared functions across both shells, choose your preference
- **Highly usable Vim configuration** - Sensible defaults, relative line numbers, persistent undo, system clipboard integration, and comprehensive inline documentation

## Supported Platforms

- **macOS** - Full support with Homebrew package management
- **Linux** - Native support (tested on Ubuntu/Debian)
- **WSL** - Windows Subsystem for Linux with Windows VS Code integration
- **GitHub Codespaces** - Automatic installation via [dotfiles integration](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles)
- **Dev Containers** - VS Code extensions automatically installed

## Quick Start

**One-line install:**
```bash
curl -fsSL https://raw.githubusercontent.com/rafeco/dotfiles/main/bootstrap.sh | bash
```

**Or clone manually:**
```bash
git clone https://github.com/rafeco/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer will symlink configs from `home/*` to `~/.*`, backup existing files, and detect your environment (macOS/Linux/Codespaces).

**After installation, optionally install recommended packages:**

**macOS:**
```bash
~/.dotfiles/brew-setup
```

**Ubuntu/Debian:**
```bash
~/.dotfiles/ubuntu-setup
```

See [Package Management](#package-management) for details.

## Requirements

**Minimum requirements:**

**macOS:**
```bash
brew install git tmux vim
```

**Ubuntu/Debian/WSL:**
```bash
sudo apt install git tmux vim
```

Git is required; tmux and vim are optional.

## Core Configuration

### Shell - Bash & Zsh

Both shells share the same feature set through common functions defined in `~/.shell_functions`.

**Bash** (`home/bashrc`)
- Smart history (10k entries, no duplicates)
- Git-aware prompt with branch display
- Starship prompt support (if installed)
- Platform-specific aliases and PATH configuration

**Zsh** (`home/zshrc`)
- All Bash features plus zsh enhancements
- Menu-style auto-completion
- Auto-cd, directory stack (`d`, `1`, `2`)
- Arrow key history search
- Plugin support (zsh-autosuggestions, zsh-syntax-highlighting)

**Common Aliases:**
- File operations: `ll`, `la`, `l`, `..`, `...`, `....`
- Git shortcuts: `gs`, `ga`, `gc`, `gd`, `gl`, `gp`, `gpl`
- Safety: `rm -i`, `cp -i`, `mv -i`
- Ubuntu aliases: `bat` → `batcat`, `fd` → `fdfind`

**Common Functions:**
- `mkcd` - Create and enter a directory
- `extract` - Smart archive extraction
- `psgrep` - Search running processes
- `search` - Find files and content
- `venv` - Python virtual environment management

### Git

Configuration in `home/gitconfig`:
- Default branch: `main`
- Auto-rebase on pull with autostash
- Histogram diff, zdiff3 merge conflicts
- Platform-specific credential helper via `.gitconfig.platform`
- Useful aliases:
  - `lg` - Pretty graph log
  - `s` - Status
  - `up` - Pull with rebase
  - `sw/swc` - Switch branches
  - `amend` - Amend last commit

Use `~/.gitconfig.local` for personal overrides (automatically included, never touched by installer).

### tmux

Configuration in `home/tmux.conf`:
- Prefix: `Ctrl-\`
- Mouse support enabled
- Vi copy mode
- Intuitive splits: `|` vertical, `-` horizontal
- Vim-style pane navigation: `h/j/k/l`
- 50k line scrollback history
- 256 color support

### Vim

Configuration in `home/vimrc`:
- Relative line numbers
- Mouse support
- Persistent undo (survives across sessions)
- System clipboard integration
- Per-language indentation (2/4 spaces)
- Auto-trim trailing whitespace
- True color support
- Comprehensive inline documentation

## Optional Setup

### Package Management

Interactive scripts to install recommended development tools.

**macOS - Homebrew:**
```bash
~/.dotfiles/brew-setup
```

**Ubuntu/Debian - APT:**
```bash
~/.dotfiles/ubuntu-setup
```

Both scripts:
- Scan your system to show which packages are already installed
- List missing packages with clear categorization
- Confirm before installing anything
- Handle installation failures gracefully

**Packages installed:**

**GNU Core Utilities** (macOS compatibility layer)
- `bash` - Modern Bash shell (macOS ships with ancient version)
- `coreutils`, `grep`, `gnu-sed`, `gawk`, `findutils`, `diffutils`

**Zsh Enhancements**
- `zsh-syntax-highlighting` - Fish-like syntax highlighting
- `zsh-autosuggestions` - Fish-like command suggestions
- `zsh-completions` - Additional completion definitions

**Development & Productivity**
- `git`, `gh` - Version control and GitHub CLI
- `jq` - JSON processor
- `fzf` - Fuzzy finder
- `ripgrep`, `fd` - Fast search tools
- `bat` - cat with syntax highlighting
- `eza` - Modern ls replacement
- `tldr` - Simplified man pages
- `htop`, `tree`, `wget`, `watch`

**Linting & Formatting**
- `shellcheck` - Shell script static analysis
- `shfmt` - Shell script formatter

**Ubuntu-specific notes:**
- Most GNU utilities are already installed by default
- Some packages have different command names: `fd-find` → `fdfind`, `bat` → `batcat` (aliases included in dotfiles)
- Special packages (`gh`, `eza`, `tldr`, `shfmt`) require additional installation steps with instructions provided by the script

### VS Code Integration

VS Code settings are managed separately from the main dotfiles installation:

```bash
~/.dotfiles/vscode-install.sh
```

**Platform detection:**
- **macOS/Linux**: Symlinks settings files to VS Code's User directory
- **WSL (Windows)**: Copies settings to Windows VS Code and installs extensions via `cmd.exe`
- **Dev Containers**: Extensions automatically installed via `.devcontainer/devcontainer.json`

**What's installed:**
- `settings.json` - Editor preferences (Vim keybindings, theme, formatting)
- `keybindings.json` - Custom keyboard shortcuts
- `snippets/` - Code snippets directory
- Extensions from `extensions.txt`:
  - Python development (debugpy, pylance, python)
  - Vim emulation
  - GitLens
  - Prettier
  - Error Lens
  - Material Icon Theme

**Note for WSL users**: Settings are copied (not symlinked) to work across the WSL/Windows boundary. Re-run the installer after updating your dotfiles to sync changes.

**Update extensions list:**
```bash
code --list-extensions > ~/.dotfiles/vscode/extensions.txt
```

See `vscode/README.md` for more details.

### Claude Code

The installer automatically installs [Claude Code](https://claude.ai/code), Anthropic's AI coding CLI. After installation, `claude` is available in your terminal.

### Starship Prompt

Both Bash and Zsh will automatically use [Starship](https://starship.rs) if it's installed, falling back to custom git-aware prompts otherwise.

```bash
# Install Starship (optional)
brew install starship

# Optional: Install a Nerd Font for icons
brew install font-fira-code-nerd-font

# Apply a preset or create custom config
starship preset nerd-font-symbols -o ~/.config/starship.toml
```

## Advanced Features

### Python Virtual Environments

Smart virtual environment management with the `venv` command:

- Toggle activation/deactivation with a single command
- Automatically finds `.venv` or `venv` directories
- Offers to create `.venv` if none exists
- Properly manages PATH to prioritize installed packages

**Usage:**
```bash
venv        # Activate/deactivate venv in current directory
```

### GitHub Account Switching

Config-driven account management supporting unlimited GitHub accounts.

**Commands:**
- `gh-setup` - Interactive wizard to add/edit/remove accounts
  - Shows list of configured accounts when removing
  - Automatically reloads shell after saving changes
- `gh-{name}` - Dynamic commands created for each configured account
  - Example: `gh-rafeco`, `gh-work`, `gh-client`
- `gh-whoami` - Display current account status

**Features:**
- Automatically updates gh CLI and git user name/email
- Uses git config (INI) format for easy editing
- Configuration stored in `~/.gh-accounts` (not tracked in git)
- Template provided in `home/gh-accounts.example`

**Setup:**
```bash
cp ~/.dotfiles/home/gh-accounts.example ~/.gh-accounts
# Edit ~/.gh-accounts to add your accounts
gh-setup  # Or use interactive wizard
```

## Customization

**Edit configuration files:**
- Edit files in `home/` directory
- Re-run `./install.sh` to update symlinks

**Personal Git settings:**
- Use `~/.gitconfig.local` for personal Git overrides
- Automatically included by main gitconfig
- Never touched by the installer

**Shell customization:**
- Edit `~/.bashrc.local` or `~/.zshrc.local` for personal shell settings (optional)
- Shared functions can be extended in `~/.shell_functions.local` (optional)

## License

MIT
