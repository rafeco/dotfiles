# VS Code Settings

This directory contains VS Code user settings managed via dotfiles. The primary purpose of this configuration is to provide **Vim keybindings** in VS Code that align with the vimrc settings, creating a consistent editing experience across both editors.

## Vim Configuration

The settings in this directory configure VS Code's Vim extension to match the behavior defined in the `.vimrc` file, ensuring:

- Consistent keybindings between Vim and VS Code
- Aligned editor behaviors (indentation, search, navigation)
- Muscle memory transfer between both editors
- Custom key mappings that work identically in both environments

This allows seamless switching between traditional Vim and VS Code without having to adjust to different key behaviors.

## Files

- `settings.json` - User preferences including Vim extension configuration, theme, font, and editor behavior
- `keybindings.json` - Custom keyboard shortcuts that align with Vim/vimrc keybindings
- `snippets/` - Code snippets
- `extensions.txt` - List of installed extensions (includes Vim extension)

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
