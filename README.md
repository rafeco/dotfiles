# dotfiles

Modern dotfiles for Git, Bash, Zsh, tmux, and Vim. Works on macOS, Linux, and GitHub Codespaces.

## Quick Start

```bash
git clone https://github.com/rafeco/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer will symlink configs from `home/*` to `~/.*`, backup existing files, and detect your environment (macOS/Linux/Codespaces).

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
- Git-aware prompt with branch display
- Aliases: `ll`, `..`, `...`, git shortcuts (`gs`, `ga`, `gc`, `gd`, `gl`)
- Functions: `mkcd`, `extract`, `psgrep`, `search`
- Platform detection for macOS/Linux

### Zsh (`home/zshrc`)
- All Bash features plus zsh enhancements
- Menu-style auto-completion
- Auto-cd, directory stack (`d`, `1`, `2`)
- Arrow key history search
- Plugin support (zsh-autosuggestions, zsh-syntax-highlighting)

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
