#!/bin/bash
# Install dotfiles for GitHub Codespaces and local development

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create backup directory if we're overwriting files
mkdir -p "$BACKUP_DIR"

# Function to safely link a file
link_file() {
  local src="$1"
  local dest="$2"

  # If destination exists and is not a symlink, back it up
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  Backing up existing $dest to $BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/"
  fi

  # Remove existing symlink if present
  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  # Create the symlink
  echo "  Linking $src -> $dest"
  ln -sf "$src" "$dest"
}

# Install home directory dotfiles
echo ""
echo "Installing home directory dotfiles..."
for file in "$DOTFILES_DIR"/home/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    link_file "$file" "$HOME/.$filename"
  fi
done

# Install Claude Code configuration
echo ""
echo "Installing Claude Code configuration..."
mkdir -p "$HOME/.claude"
if [ -d "$DOTFILES_DIR/home/claude" ]; then
  for file in "$DOTFILES_DIR"/home/claude/*; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      link_file "$file" "$HOME/.claude/$filename"
    fi
  done
fi

# Create necessary directories
echo ""
echo "Creating necessary directories..."
mkdir -p "$HOME/.vim/undo"
mkdir -p "$HOME/.vim/skel"

# Create a simple Python skeleton if it doesn't exist
if [ ! -f "$HOME/.vim/skel/skeleton.py" ]; then
  echo "  Creating Python skeleton file..."
  cat > "$HOME/.vim/skel/skeleton.py" << 'EOF'
#!/usr/bin/env python3
"""
Module docstring
"""


def main():
    """Main function."""
    pass


if __name__ == "__main__":
    main()
EOF
fi

# Detect OS / container environment
OS="$(uname -s)"
IS_DOCKER=false
if [ -f "/.dockerenv" ] || grep -qa docker /proc/1/cgroup 2>/dev/null; then
  IS_DOCKER=true
fi

echo ""
echo "Detected OS: $OS"
if [ "$IS_DOCKER" = true ]; then
  echo "Detected Docker container environment"
fi

# Codespaces-specific setup
if [ -n "$CODESPACES" ]; then
  echo "Detected GitHub Codespaces environment"
  echo "  Codespaces-specific Git settings will be applied automatically."
fi

# macOS-specific setup
if [[ "$OS" == "Darwin" ]]; then
  echo "Detected macOS environment"
  echo "  Setting up macOS-specific configurations..."

  # Check for Homebrew
  if command -v brew &> /dev/null; then
    echo "  ✓ Homebrew found"
  else
    echo "  ⚠️  Homebrew not found. Install from https://brew.sh"
  fi
fi

# Configure platform-specific Git settings
echo ""
echo "Configuring platform-specific Git settings..."
PLATFORM_GITCONFIG=""
if [ -n "$CODESPACES" ] && [ -f "$DOTFILES_DIR/platform/gitconfig.codespaces" ]; then
  PLATFORM_GITCONFIG="$DOTFILES_DIR/platform/gitconfig.codespaces"
elif [[ "$OS" == "Darwin" ]] && [ -f "$DOTFILES_DIR/platform/gitconfig.macos" ]; then
  PLATFORM_GITCONFIG="$DOTFILES_DIR/platform/gitconfig.macos"
elif [[ "$OS" == "Linux" ]] && [ -f "$DOTFILES_DIR/platform/gitconfig.linux" ]; then
  PLATFORM_GITCONFIG="$DOTFILES_DIR/platform/gitconfig.linux"
fi

if [ -n "$PLATFORM_GITCONFIG" ]; then
  link_file "$PLATFORM_GITCONFIG" "$HOME/.gitconfig.platform"
  echo "  Applied $(basename "$PLATFORM_GITCONFIG")"
else
  if [ ! -f "$HOME/.gitconfig.platform" ]; then
    touch "$HOME/.gitconfig.platform"
  fi
  echo "  No platform override found. Using ~/.gitconfig.platform as a local override."
fi

# Install Claude Code if not already installed
if [ ! -f "$HOME/.claude/bin/claude" ] && [ ! -f "$HOME/.local/bin/claude" ]; then
  echo ""
  echo "Installing Claude Code..."
  if curl -fsSL https://claude.ai/install.sh | bash; then
    echo "  ✓ Claude Code installed successfully"
    # Source the shell config to get claude in PATH for next steps
    export PATH="$HOME/.claude/bin:$PATH"
  else
    echo "  ⚠️  Claude Code installation failed. You can install manually:"
    echo "     curl -fsSL https://claude.ai/install.sh | bash"
  fi
fi

echo ""
echo "✅ Dotfiles installation complete!"
echo ""

# Show backup location if we created backups
if [ "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
  echo "Original files backed up to: $BACKUP_DIR"
else
  rmdir "$BACKUP_DIR" 2>/dev/null || true
fi

# Provide next steps
echo ""
echo "Restart your shell to apply changes:"
if [[ "$OS" == "Darwin" ]]; then
  echo "  source ~/.zshrc (or ~/.bash_profile)"
else
  echo "  source ~/.bashrc"
fi
if [[ "$OS" == "Darwin" ]]; then
  echo ""
  echo "Optional setup:"
  echo "  Run ~/.dotfiles/brew-setup to install recommended Homebrew packages"
  echo ""
fi
