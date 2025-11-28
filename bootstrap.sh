#!/bin/bash
# Bootstrap script for dotfiles installation
# Usage: curl -fsSL https://raw.githubusercontent.com/rafeco/dotfiles/main/bootstrap.sh | bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="https://github.com/rafeco/dotfiles.git"

echo "Installing dotfiles..."
echo ""

# Clone the repository if it doesn't exist
if [ -d "$DOTFILES_DIR" ]; then
  echo "Dotfiles directory already exists at $DOTFILES_DIR"
  echo "Updating repository..."
  cd "$DOTFILES_DIR"
  git pull --rebase
else
  echo "Cloning dotfiles repository to $DOTFILES_DIR..."
  git clone "$REPO_URL" "$DOTFILES_DIR"
  cd "$DOTFILES_DIR"
fi

echo ""
echo "Running installer..."
echo ""

# Run the installation script
./install.sh
