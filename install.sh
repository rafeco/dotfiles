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
if [ -f "$DOTFILES_DIR/.claude/settings.json" ]; then
  link_file "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
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

# Detect OS
OS="$(uname -s)"
echo ""
echo "Detected OS: $OS"

# Codespaces-specific setup
if [ -n "$CODESPACES" ]; then
  echo "Detected GitHub Codespaces environment"
  echo "  Setting up Codespaces-specific configurations..."

  # Ensure git credential helper is configured for Codespaces
  if [ -f "/.codespaces/bin/gitcredential_github.sh" ]; then
    git config --global --unset-all credential.helper 2>/dev/null || true
    git config --global credential.helper "/.codespaces/bin/gitcredential_github.sh"
    git config --global credential."https://github.com".helper "/.codespaces/bin/gitcredential_github.sh"
    git config --global credential."https://gist.github.com".helper "/.codespaces/bin/gitcredential_github.sh"
  fi

  # Set VS Code as default editor if available
  if command -v code &> /dev/null; then
    git config --global core.editor "code --wait"
  fi
fi

# macOS-specific setup
if [[ "$OS" == "Darwin" ]]; then
  echo "Detected macOS environment"
  echo "  Setting up macOS-specific configurations..."

  # On macOS, use osxkeychain for git credentials if not in Codespaces
  if [ -z "$CODESPACES" ]; then
    # Remove any existing credential helpers and set osxkeychain
    git config --global --unset-all credential.helper 2>/dev/null || true
    git config --global --remove-section credential."https://github.com" 2>/dev/null || true
    git config --global --remove-section credential."https://gist.github.com" 2>/dev/null || true
    git config --global credential.helper osxkeychain
  fi

  # Check for Homebrew
  if command -v brew &> /dev/null; then
    echo "  ✓ Homebrew found"
  else
    echo "  ⚠️  Homebrew not found. Install from https://brew.sh"
  fi
fi

# Check for required tools and provide helpful messages
echo ""
echo "Checking for required tools..."

# Install Claude Code if not already installed
if ! command -v claude &> /dev/null; then
  echo "  Installing Claude Code..."
  if curl -fsSL https://claude.ai/install.sh | bash; then
    echo "  ✓ Claude Code installed successfully"
    # Source the shell config to get claude in PATH for next steps
    export PATH="$HOME/.claude/bin:$PATH"
  else
    echo "  ⚠️  Claude Code installation failed. You can install manually:"
    echo "     curl -fsSL https://claude.ai/install.sh | bash"
  fi
else
  echo "  ✓ Claude Code found"
fi

if ! command -v tmux &> /dev/null; then
  if [[ "$OS" == "Darwin" ]]; then
    echo "  ⚠️  tmux not found. Install with: brew install tmux"
  else
    echo "  ⚠️  tmux not found. Install with: sudo apt-get install tmux"
  fi
else
  echo "  ✓ tmux found"
fi

if ! command -v vim &> /dev/null; then
  if [[ "$OS" == "Darwin" ]]; then
    echo "  ⚠️  vim not found. Install with: brew install vim"
  else
    echo "  ⚠️  vim not found. Install with: sudo apt-get install vim"
  fi
else
  echo "  ✓ vim found"
fi

if ! command -v git &> /dev/null; then
  if [[ "$OS" == "Darwin" ]]; then
    echo "  ⚠️  git not found. Install Xcode Command Line Tools"
  else
    echo "  ⚠️  git not found. Install with: sudo apt-get install git"
  fi
else
  echo "  ✓ git found"
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
echo "Next steps:"
if [[ "$OS" == "Darwin" ]]; then
  echo "  1. Restart your shell or run: source ~/.zshrc (or ~/.bash_profile)"
else
  echo "  1. Restart your shell or run: source ~/.bashrc"
fi
echo "  2. Start tmux with: tmux"
echo "  3. Open vim to test: vim"
echo ""

if [ -n "$CODESPACES" ]; then
  echo "For GitHub Codespaces:"
  echo "  - Your git credentials are automatically configured"
  echo "  - tmux and vim are ready to use"
  echo "  - Restart your terminal to apply changes"
  echo ""
elif [[ "$OS" == "Darwin" ]]; then
  echo "For macOS:"
  echo "  - Git credential helper set to osxkeychain"
  echo "  - If using iTerm2, enable tmux integration for best experience"
  echo "  - Consider installing additional tools with Homebrew"
  echo ""
fi
