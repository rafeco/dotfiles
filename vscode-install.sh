#!/bin/bash
# Install VS Code settings from dotfiles

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VSCODE_DIR="$DOTFILES_DIR/vscode"
BACKUP_DIR="$HOME/.dotfiles_backup_vscode_$(date +%Y%m%d_%H%M%S)"

# Detect OS
OS="$(uname -s)"

# Set VS Code User directory based on OS
USE_WINDOWS_VSCODE=false
if [[ "$OS" == "Darwin" ]]; then
  VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OS" == "Linux" ]]; then
  # Check if we're on WSL
  if grep -qi microsoft /proc/version 2>/dev/null; then
    # WSL detected - check for Windows VS Code
    WINDOWS_USER=$(find /mnt/c/Users/ -maxdepth 1 -type d ! -name "Users" ! -name "Default" ! -name "Public" 2>/dev/null | head -1)
    if [[ -n "$WINDOWS_USER" ]]; then
      WINDOWS_VSCODE_DIR="$WINDOWS_USER/AppData/Roaming/Code/User"
      if [[ -d "$WINDOWS_VSCODE_DIR" ]]; then
        VSCODE_USER_DIR="$WINDOWS_VSCODE_DIR"
        USE_WINDOWS_VSCODE=true
        echo "Detected WSL with Windows VS Code"
      else
        VSCODE_USER_DIR="$HOME/.config/Code/User"
      fi
    else
      VSCODE_USER_DIR="$HOME/.config/Code/User"
    fi
  else
    VSCODE_USER_DIR="$HOME/.config/Code/User"
  fi
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

# Function to safely link or copy a file
link_file() {
  local src="$1"
  local dest="$2"

  # If destination exists and is not a symlink, back it up
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  Backing up existing $(basename "$dest") to $BACKUP_DIR"
    cp -r "$dest" "$BACKUP_DIR/"
  fi

  # Remove existing symlink or file if present
  if [ -L "$dest" ] || [ -e "$dest" ]; then
    rm -rf "$dest"
  fi

  # For Windows VS Code on WSL, copy instead of symlink
  # (Windows can't follow symlinks to Linux paths)
  if [[ "$USE_WINDOWS_VSCODE" == "true" ]]; then
    echo "  Copying $src -> $dest"
    cp -r "$src" "$dest"
  else
    # Create the symlink for native Linux/macOS
    echo "  Linking $src -> $dest"
    ln -sf "$src" "$dest"
  fi
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

# Link snippets directory if it exists
if [ -d "$VSCODE_DIR/snippets" ]; then
  echo ""
  echo "Linking VS Code snippets..."
  link_file "$VSCODE_DIR/snippets" "$VSCODE_USER_DIR/snippets"
fi

# Install extensions if extensions.txt exists
if [ -f "$VSCODE_DIR/extensions.txt" ]; then
  echo ""
  echo "Installing VS Code extensions..."

  # Determine which code command to use
  if [[ "$USE_WINDOWS_VSCODE" == "true" ]]; then
    # For Windows VS Code on WSL, call through cmd.exe
    # Test if it works by checking version
    if cmd.exe /c code --version &> /dev/null; then
      CODE_CMD_AVAILABLE=true
      CODE_CMD="cmd.exe /c code"
    else
      CODE_CMD_AVAILABLE=false
      CODE_CMD="cmd.exe /c code"
    fi
  else
    # For native Linux/macOS, check if code command exists
    if command -v code &> /dev/null; then
      CODE_CMD_AVAILABLE=true
      CODE_CMD="code"
    else
      CODE_CMD_AVAILABLE=false
      CODE_CMD="code"
    fi
  fi

  # Install extensions if code command is available
  if [[ "$CODE_CMD_AVAILABLE" == "true" ]]; then
    # Change to a Windows-accessible directory to avoid UNC path warnings
    ORIGINAL_DIR=$(pwd)
    cd /mnt/c 2>/dev/null || cd /tmp

    # Read extensions into an array to avoid input conflicts
    mapfile -t extensions < <(grep -v '^\s*$' "$VSCODE_DIR/extensions.txt" | grep -v '^\s*#')

    for extension in "${extensions[@]}"; do
      echo "  Installing $extension..."
      # Capture output and filter noise
      output=$($CODE_CMD --install-extension "$extension" --force 2>&1)
      # Show only important messages
      echo "$output" | grep -E "(successfully installed|already installed|Failed|Error|not found)" | sed 's/^/    /' || true
    done

    # Return to original directory
    cd "$ORIGINAL_DIR"

    echo "  ✓ Extensions installed"
  else
    echo "  Warning: VS Code 'code' command not found in Windows PATH."
    echo "  Skipping extension installation."
    echo ""
    echo "  To install extensions manually, open PowerShell and run:"
    echo "    Get-Content $(wslpath -w "$VSCODE_DIR/extensions.txt") | ForEach-Object { code --install-extension \$_ --force }"
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

# Warn about syncing for Windows VS Code
if [[ "$USE_WINDOWS_VSCODE" == "true" ]]; then
  echo ""
  echo "Note: Settings are copied (not symlinked) for Windows VS Code."
  echo "Run this script again after updating your dotfiles to sync changes."
fi
