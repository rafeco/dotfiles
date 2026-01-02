# dotfiles

This is my development environment. There are many like it, but this one is mine.

Modern dotfiles for Git, Bash, Zsh, tmux, Vim, and VS Code. Works on macOS (with Homebrew), Linux, WSL (Windows Subsystem for Linux), and GitHub Codespaces.

## Key Features

- **Easy Python virtual environment management** - One `venv` command to activate, deactivate, or create `.venv` directories
- **Seamless GitHub account switching** - Manage unlimited GitHub accounts with `gh-setup`, switch between them instantly with `gh-{name}` commands
- **Works with both Bash and Zsh** - Identical feature set and shared functions across both shells, choose your preference
- **Highly usable Vim configuration** - Sensible defaults, relative line numbers, persistent undo, system clipboard integration, and comprehensive inline documentation

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

**After installation (macOS only):**
```bash
~/.dotfiles/home/brew-setup
```

This interactive script installs recommended development packages via Homebrew. See [Homebrew Package Management](#homebrew-package-management) for details.

**Optional - Starship Prompt:**

Both Bash and Zsh will automatically use [Starship](https://starship.rs) if it's installed, falling back to custom git-aware prompts otherwise.

```bash
# Install Starship (optional)
brew install starship

# Optional: Install a Nerd Font for icons
brew install font-fira-code-nerd-font

# Apply a preset or create custom config
starship preset nerd-font-symbols -o ~/.config/starship.toml
```

### GitHub Codespaces

Set this repository as your [dotfiles repository](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles) in GitHub Settings → Codespaces for automatic installation.

## What's Included

### Git (`home/gitconfig`)
- Default branch: `main`
- Auto-rebase on pull with autostash
- Histogram diff, zdiff3 merge conflicts
- Useful aliases: `lg` (graph log), `s` (status), `up` (pull+rebase), `sw/swc` (switch branches), `amend`
- Platform-specific credential helper via `.gitconfig.platform` (macOS keychain, Linux/Docker cache, Codespaces helper)

### Bash (`home/bashrc`)
- Smart history (10k, no duplicates)
- Starship prompt (if installed), otherwise git-aware prompt with branch display
- Aliases: `ll`, `..`, `...`, git shortcuts (`gs`, `ga`, `gc`, `gd`, `gl`)
- Functions: `mkcd`, `extract`, `psgrep`, `search`, `venv`
- Platform detection for macOS/Linux

### Zsh (`home/zshrc`)
- All Bash features plus zsh enhancements
- Starship prompt (if installed), otherwise git-aware prompt with branch display
- Menu-style auto-completion
- Auto-cd, directory stack (`d`, `1`, `2`)
- Arrow key history search
- Plugin support (zsh-autosuggestions, zsh-syntax-highlighting)

### Python Virtual Environments
- `venv` - Smart virtual environment management
  - Toggle activation/deactivation with a single command
  - Automatically finds `.venv` or `venv` directories
  - Offers to create `.venv` if none exists
  - Properly manages PATH to prioritize installed packages

### GitHub Account Switching
- Config-driven account management supporting unlimited accounts
- `gh-setup` - Interactive wizard to add/edit/remove accounts
  - Shows list of configured accounts when removing
  - Automatically reloads shell after saving changes
- `gh-{name}` - Dynamic commands created for each configured account
  - Example: `gh-rafeco`, `gh-etsy`, `gh-consulting`
- `gh-whoami` - Display current account status
- Automatically updates gh CLI and git user name/email
- Uses git config (INI) format for easy editing
- Configuration stored in `~/.gh-accounts` (not tracked in git)
- Template provided in `home/gh-accounts.example`

### Homebrew Package Management

Run `~/.dotfiles/home/brew-setup` after installation to set up recommended development packages. The script:
- Scans your system to show which packages are already installed
- Lists missing packages with clear categorization
- Confirms before installing anything
- Handles installation failures gracefully

**Packages installed by category:**

**GNU Core Utilities** (macOS compatibility layer)
- `bash` - Modern Bash shell (macOS ships with ancient version)
- `coreutils` - GNU versions of basic utilities (ls, cat, etc.)
- `grep` - GNU grep with better regex support
- `gnu-sed` - GNU sed for consistent behavior across platforms
- `gawk` - GNU awk interpreter
- `findutils` - GNU find, xargs, locate
- `diffutils` - GNU diff, cmp, sdiff

**Zsh Enhancements**
- `zsh-syntax-highlighting` - Fish-like syntax highlighting
- `zsh-autosuggestions` - Fish-like command suggestions
- `zsh-completions` - Additional completion definitions

**Development & Productivity**
- `git` - Latest Git version
- `gh` - GitHub CLI tool
- `jq` - Command-line JSON processor
- `fzf` - Fuzzy finder for command history, files, and more
- `ripgrep` - Faster alternative to grep
- `fd` - Faster alternative to find
- `bat` - cat with syntax highlighting
- `eza` - Modern replacement for ls
- `tldr` - Simplified man pages
- `htop` - Interactive process viewer
- `tree` - Directory tree visualization
- `wget` - Network downloader
- `watch` - Execute commands periodically

**Linting & Formatting**
- `shellcheck` - Shell script static analysis
- `shfmt` - Shell script formatter

### tmux (`home/tmux.conf`)
- Prefix: `Ctrl-\`
- Mouse support enabled
- Vi copy mode
- Intuitive splits: `|` vertical, `-` horizontal
- Vim-style navigation: `h/j/k/l`
- 50k line history, 256 colors

### Vim (`home/vimrc`)
- Line numbers (relative)
- Mouse support
- Persistent undo
- System clipboard integration
- Per-language indentation (2/4 spaces)
- Auto-trim trailing whitespace
- True color support

### Claude Code

The installer automatically installs [Claude Code](https://claude.ai/code), Anthropic's AI coding CLI. After installation, `claude` is available in your terminal.

### VS Code Settings

VS Code settings are managed separately from the main dotfiles installation:

```bash
~/.dotfiles/vscode-install.sh
```

The installer automatically detects your environment:
- **macOS/Linux**: Symlinks settings files to VS Code's User directory
- **WSL (Windows)**: Copies settings to Windows VS Code and installs extensions via `cmd.exe`

This will install:
- `settings.json` - Editor preferences
- `keybindings.json` - Custom keyboard shortcuts (if present)
- `snippets/` - Code snippets directory
- Extensions from `extensions.txt`

**Note for WSL users**: Settings are copied (not symlinked) to work across the WSL/Windows boundary. Re-run the installer after updating your dotfiles to sync changes.

To update your extensions list after installing new ones:
```bash
code --list-extensions > ~/.dotfiles/vscode/extensions.txt
```

See `vscode/README.md` for more details.

## Requirements

Install with your package manager:

**macOS:**
```bash
brew install git tmux vim
```

**Linux/WSL:**
```bash
sudo apt-get install git tmux vim
```

Git is required; tmux and vim are optional.

## Customization

Edit files in `home/` and re-run `./install.sh` to update.  
Use `~/.gitconfig.local` for personal Git overrides—it's included automatically and never touched by the installer.

## License

MIT
