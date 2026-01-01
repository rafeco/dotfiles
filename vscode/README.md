# VS Code Settings

This directory contains VS Code user settings managed via dotfiles.

## Files

- `settings.json` - User preferences (theme, font, editor behavior)
- `keybindings.json` - Custom keyboard shortcuts (optional)
- `snippets/` - Code snippets
- `extensions.txt` - List of installed extensions

## Installation

Run the VS Code install script:

```bash
~/.dotfiles/vscode-install.sh
```

This will:
1. Backup existing VS Code settings
2. Create symlinks from this directory to VS Code's User directory
3. Install extensions listed in `extensions.txt`

## Updating Extensions List

To update the extensions list after installing new extensions:

```bash
code --list-extensions > ~/.dotfiles/vscode/extensions.txt
```

## Manual Installation

If you prefer to install extensions manually:

```bash
cat ~/.dotfiles/vscode/extensions.txt | xargs -L 1 code --install-extension
```

## Location

- **macOS**: `~/Library/Application Support/Code/User/`
- **Linux**: `~/.config/Code/User/`
