#!/bin/bash
# Install VS Code settings from dotfiles

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VSCODE_DIR="$DOTFILES_DIR/vscode"
BACKUP_DIR="$HOME/.dotfiles_backup_vscode_$(date +%Y%m%d_%H%M%S)"

# Detect OS
OS="$(uname -s)"

# Set VS Code User directory based on OS
if [[ "$OS" == "Darwin" ]]; then
  VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OS" == "Linux" ]]; then
  VSCODE_USER_DIR="$HOME/.config/Code/User"
else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Installing VS Code settings from $VSCODE_DIR"
echo "VS Code User directory: $VSCODE_USER_DIR"

# Check if VS Code is installed
if [ ! -d "$VSCODE_USER_DIR" ]; then
  echo "Warning: VS Code User directory not found at $VSCODE_USER_DIR"
  echo "Please install VS Code first or ensure it has been run at least once."
  exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to safely link a file
link_file() {
  local src="$1"
  local dest="$2"

  # If destination exists and is not a symlink, back it up
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  Backing up existing $(basename "$dest") to $BACKUP_DIR"
    cp -r "$dest" "$BACKUP_DIR/"
  fi

  # Remove existing symlink if present
  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  # Create the symlink
  echo "  Linking $src -> $dest"
  ln -sf "$src" "$dest"
}

# Link settings.json
echo ""
echo "Linking VS Code settings..."
if [ -f "$VSCODE_DIR/settings.json" ]; then
  link_file "$VSCODE_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
else
  echo "  Warning: settings.json not found in $VSCODE_DIR"
fi

# Link keybindings.json if it exists
if [ -f "$VSCODE_DIR/keybindings.json" ]; then
  echo ""
  echo "Linking VS Code keybindings..."
  link_file "$VSCODE_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
fi

# Link snippets directory
echo ""
echo "Linking VS Code snippets..."
if [ -d "$VSCODE_DIR/snippets" ]; then
  link_file "$VSCODE_DIR/snippets" "$VSCODE_USER_DIR/snippets"
else
  echo "  Warning: snippets directory not found in $VSCODE_DIR"
fi

# Install extensions if extensions.txt exists
if [ -f "$VSCODE_DIR/extensions.txt" ]; then
  echo ""
  echo "Installing VS Code extensions..."

  # Check if code command is available
  if command -v code &> /dev/null; then
    while IFS= read -r extension; do
      # Skip empty lines and comments
      [[ -z "$extension" || "$extension" =~ ^# ]] && continue

      echo "  Installing $extension..."
      code --install-extension "$extension" --force
    done < "$VSCODE_DIR/extensions.txt"
    echo "  ✓ Extensions installed"
  else
    echo "  Warning: 'code' command not found. Skipping extension installation."
    echo "  To install extensions manually, run:"
    echo "    cat $VSCODE_DIR/extensions.txt | xargs -L 1 code --install-extension"
  fi
fi

echo ""
echo "✅ VS Code settings installation complete!"

# Show backup location if we created backups
if [ "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
  echo ""
  echo "Original files backed up to: $BACKUP_DIR"
else
  rmdir "$BACKUP_DIR" 2>/dev/null || true
fi

echo ""
echo "Restart VS Code to apply changes."
