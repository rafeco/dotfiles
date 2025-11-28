# dotfiles

Modern dotfiles configuration for GitHub Codespaces, VS Code, and Unix-like environments.

## Features

- **Git**: Modern Git configuration with helpful aliases, auto-rebase, and Codespaces credential integration
- **Bash**: Quality of life improvements with better history, aliases, and useful functions
- **Zsh**: Enhanced zsh config with auto-completion, git integration, and directory navigation
- **tmux**: Updated tmux config with mouse support, modern color settings, and intuitive keybindings
- **Vim**: Enhanced Vim configuration with persistent undo, modern defaults, and Codespaces compatibility
- **Easy Installation**: Automated installation script with backup and safety features

## Quick Start

### GitHub Codespaces

This repository is ready to use with GitHub Codespaces! Simply:

1. Click "Code" → "Create codespace on main" in GitHub
2. The dotfiles will be automatically installed via `.devcontainer/devcontainer.json`
3. Start using tmux, vim, and git with your customized settings

Alternatively, you can use this as your [personal dotfiles repository](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles):

1. Go to your GitHub Settings → Codespaces
2. Set this repository as your dotfiles repository
3. It will be automatically cloned and installed in all your Codespaces

### Local Installation

#### macOS

```bash
# Clone this repository
git clone https://github.com/rafeco/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installation script
./install.sh
```

On macOS, the script will:
- Detect your macOS environment automatically
- Configure git to use `osxkeychain` for credential storage
- Provide Homebrew installation commands if tools are missing
- Work with your default shell (zsh or bash)

**Install required tools with Homebrew:**
```bash
brew install tmux vim git
```

#### Linux / WSL

```bash
# Clone this repository
git clone https://github.com/rafeco/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installation script
./install.sh
```

**Install required tools:**
```bash
sudo apt-get install tmux vim git
```

### Common for all platforms

The installation script will:
- Create symlinks from `home/*` to `~/.*`
- Backup any existing dotfiles to `~/.dotfiles_backup_[timestamp]`
- Create necessary directories for vim
- Detect and configure for Codespaces environment
- Check for required tools

### Manual Installation (using Make)

```bash
make install_home
```

## What's Included

### Bash Configuration (`home/bashrc`)

Modern bash setup with quality of life improvements:
- **Smart History**: 10k commands, no duplicates, immediate append
- **Better Completion**: Case-insensitive, show all options
- **Git-aware Prompt**: Shows current branch in color
- **Useful Aliases**:
  - `ll` - Detailed list with human-readable sizes
  - `..`, `...` - Quick directory navigation
  - Git shortcuts (`gs`, `ga`, `gc`, `gd`, `gl`)
  - Safety aliases (`rm -i`, `cp -i`, `mv -i`)
- **Helper Functions**:
  - `mkcd` - Make directory and cd into it
  - `extract` - Extract any archive format
  - `psgrep` - Find processes by name
  - `search` - Quick filename search
- **Platform Detection**: macOS and Linux specific aliases
- **Codespaces Integration**: Auto-configures for GitHub Codespaces

### Zsh Configuration (`home/zshrc`)

Enhanced zsh with powerful features:
- **Smart History**: Shared across sessions, deduplicated
- **Auto-completion**: Menu-style, case-insensitive, colored
- **Git-aware Prompt**: Integrated with vcs_info
- **Directory Navigation**: Auto-cd, smart pushd/popd, numbered directories
- **Better Key Bindings**: Search history with arrows, word navigation
- **Command Correction**: Suggests corrections for typos
- **Plugin Support**: Auto-loads zsh-autosuggestions and zsh-syntax-highlighting
- **All Bash Features**: Plus zsh-specific improvements

### Git Configuration (`home/gitconfig`)

- Modern default branch (`main`)
- Auto-rebase on pull with stash
- Improved diff algorithm (histogram with zebra coloring)
- zdiff3 merge conflict style for better conflict resolution
- GitHub Codespaces credential helper integration
- Comprehensive aliases:
  - `git lg` - Beautiful graph log
  - `git s` - Short status with branch info
  - `git up` - Pull with rebase and autostash
  - `git amend` - Amend last commit
  - `git sw/swc` - Switch branches (modern Git commands)
  - And many more!

### tmux Configuration (`home/tmux.conf`)

- Custom prefix: `Ctrl-\` (easier to type)
- **Mouse support** enabled (great for Codespaces)
- Vi mode for copy/paste
- Modern color syntax (no deprecated options)
- Intuitive pane splitting:
  - `|` for vertical split
  - `-` for horizontal split
- Vim-style pane navigation (`h/j/k/l`)
- Increased history (50,000 lines)
- 256 color support
- Windows start at 1 (not 0)
- Auto-renumber windows

### Vim Configuration (`home/vimrc`)

- **Line numbers** with relative numbering
- **Mouse support** in all modes
- **Persistent undo** (survives closing files)
- System clipboard integration
- Modern defaults (hidden buffers, fast completion)
- Better split behavior (below/right)
- Current line highlighting
- Improved status line
- Per-language indentation:
  - 4 spaces: Python, PHP, Java, JavaScript
  - 2 spaces: TypeScript, JSON, YAML, Ruby, Scala
- Automatic trailing whitespace removal on save
- True color support (when available)
- Codespaces-specific optimizations (no swap files in cloud)

## Usage Examples

### Bash / Zsh

```bash
# Quick directory navigation
..          # Go up one directory
...         # Go up two directories
cdp         # Go to previous directory
mkcd foo    # Make directory and cd into it

# Shortcuts
ll          # Detailed list
hg pattern  # Search history
extract archive.tar.gz  # Extract any archive

# Git shortcuts
gs          # git status
ga .        # git add .
gc -m "msg" # git commit
gl          # Pretty git log

# Network
myip        # Get your public IP
ports       # Show open ports

# Utilities
now         # Current timestamp
today       # Today's date
search name # Find files by name
psgrep node # Find processes by name
```

### Zsh Specific

```bash
# Directory stack (zsh)
d           # Show recent directories
1           # Jump to directory 1 in stack
2           # Jump to directory 2 in stack

# Type a directory name to cd into it (no need for 'cd')
~/projects  # Automatically cd to ~/projects

# Better history search
# Use up/down arrows to search through history
# matching what you've typed
```

### tmux

```bash
# Start tmux
tmux

# Inside tmux:
Ctrl-\ |        # Split vertically
Ctrl-\ -        # Split horizontally
Ctrl-\ h/j/k/l  # Navigate panes
Ctrl-\ r        # Reload configuration
Ctrl-\ [        # Enter copy mode (vi keys)
```

### Git

```bash
# Beautiful commit log
git lg

# Quick status
git s

# Pull with rebase and stash
git up

# Create and switch to new branch
git swc feature-name

# Amend last commit
git amend

# Interactive add
git ap
```

### Vim

```vim
" Persistent undo means you can undo even after closing a file
" Line numbers help with navigation
" System clipboard works with y/p commands
" Mouse support lets you click to position cursor
```

## macOS-Specific Features

The dotfiles automatically detect macOS and apply appropriate configurations:

- **Git Credentials**: Uses `osxkeychain` for secure credential storage (no password re-entry)
- **Shell Detection**: Works with zsh (default since macOS Catalina) or bash
- **Zsh Default**: macOS Catalina+ uses zsh by default, fully configured with completions
- **Homebrew Integration**: Provides brew commands for missing tools
- **Optional Plugins**: Install enhanced zsh plugins with:
  ```bash
  brew install zsh-autosuggestions zsh-syntax-highlighting
  ```
- **tmux on macOS**: 
  - Full mouse support works great with macOS Terminal and iTerm2
  - iTerm2 users: Enable "tmux Integration" in Preferences for native tmux support
  - Works perfectly with trackpad gestures
- **Clipboard Integration**: Vim's system clipboard (`clipboard=unnamedplus`) works with macOS pasteboard
- **True Color**: Modern terminals like iTerm2 and Alacritty fully support true colors

## Customization

Edit the files in the `home/` directory and run `./install.sh` again to update your configurations.

## Requirements

- **Git** (required)
- **tmux** (optional, for terminal multiplexing)
- **Vim** (optional, works with default vi too)

### macOS
```bash
# Install via Homebrew
brew install git tmux vim

# Or install Xcode Command Line Tools for git
xcode-select --install
```

### Linux / Ubuntu / Debian
```bash
sudo apt-get install git tmux vim
```

### WSL (Windows Subsystem for Linux)
```bash
sudo apt-get install git tmux vim
```

## Compatibility

- **OS**: Linux, macOS (including Apple Silicon), WSL
- **Shells**: bash, zsh (default on macOS)
- **Git**: 2.23+ (for switch command)
- **tmux**: 2.1+ (tested with 3.x)
- **Vim**: 8.0+ or Neovim
- **GitHub Codespaces**: ✅ Fully supported
- **macOS**: ✅ Native support with Homebrew integration

## Contributing

Feel free to fork this repository and customize it for your own use!

## License

MIT - Feel free to use and modify as needed.

## Changelog

### 2025 Update
- Modernized all configurations for 2025
- **Added comprehensive bash and zsh configurations with QoL improvements**
- Added GitHub Codespaces support
- **Added macOS native support with Homebrew integration**
- **Auto-detection for Linux, macOS, and Codespaces environments**
- Updated tmux config (removed deprecated utf8 settings, modern color syntax)
- Enhanced gitconfig (modern Git features, better aliases)
- Improved vimrc (line numbers, mouse support, persistent undo)
- Added automated installation script with OS detection
- Added devcontainer configuration
- Updated documentation with platform-specific instructions

