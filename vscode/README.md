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

The installer automatically detects your environment and adapts accordingly:

**macOS/Linux:**
1. Backups existing VS Code settings
2. Creates symlinks from this directory to VS Code's User directory
3. Installs extensions using the `code` command

**WSL (Windows Subsystem for Linux):**
1. Detects Windows VS Code installation
2. Backs up existing settings
3. Copies (not symlinks) settings to Windows VS Code User directory
4. Installs extensions via `cmd.exe /c code` to target Windows VS Code
5. Automatically handles the WSL/Windows file system boundary

**Note for WSL users**: Since files are copied rather than symlinked, you'll need to re-run the installer after updating your dotfiles to sync changes to Windows VS Code.

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

VS Code User directory locations:

- **macOS**: `~/Library/Application Support/Code/User/`
- **Linux**: `~/.config/Code/User/`
- **WSL (Windows)**: `/mnt/c/Users/<username>/AppData/Roaming/Code/User/`

On WSL, the installer automatically detects and uses the Windows VS Code installation.
