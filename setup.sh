#!/bin/bash

# --- Environment Setup Script ---
# This script automates the installation of common development tools and
# sets up dotfiles by symlinking them to the home directory.
# It supports macOS (Homebrew), Arch Linux (Pacman), and Debian/Ubuntu (APT).

echo "Starting environment setup..."

# 1. Determine the platform and package manager
# ---------------------------------------------
PACKAGE_MANAGER=""

if command -v brew &> /dev/null; then
    PACKAGE_MANAGER="brew"
    echo "Detected macOS with Homebrew."
elif command -v pacman &> /dev/null; then
    PACKAGE_MANAGER="pacman"
    echo "Detected Arch Linux with Pacman."
elif command -v apt &> /dev/null; then
    PACKAGE_MANAGER="apt"
    echo "Detected Debian/Ubuntu with APT."
else
    echo "Error: No supported package manager (Homebrew, Pacman, APT) found."
    echo "Please install one of these or manually install the required tools."
    exit 1
fi

# Function to install packages
install_packages() {
    local packages=("$@")
    echo "Installing packages: ${packages[*]} using $PACKAGE_MANAGER..."
    case "$PACKAGE_MANAGER" in
        "brew")
            brew install "${packages[@]}"
            ;;
        "pacman")
            sudo pacman -S --noconfirm "${packages[@]}"
            ;;
        "apt")
            sudo apt update
            sudo apt install -y "${packages[@]}"
            ;;
    esac

    if [ $? -ne 0 ]; then
        echo "Error: Failed to install one or more packages."
        exit 1
    fi
}

# 2. Install specified tools
# --------------------------
REQUIRED_TOOLS=("zsh" "vim" "btop" "tmux")
install_packages "${REQUIRED_TOOLS[@]}"

# 3. Install Oh My Zsh
# --------------------
echo "Installing Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed. Skipping installation."
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Oh My Zsh."
        # Do not exit here, as other steps might still be useful
    fi
fi

# 4. Install Vundle
# -----------------
echo "Installing Vundle..."
if [ -d "$HOME/.vim/bundle/VundleVim" ]; then
    echo "Vundle is already installed. Skipping installation."
else
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone Vundle. Make sure Git is installed."
        # Do not exit here
    fi
fi

# 5. Symlink dotfiles
# -------------------
echo "Symlinking dotfiles..."

# Assuming this script is run from the root of your dotfiles repository
DOTFILES_DIR=$(pwd)

# List of dotfiles to symlink
DOTFILES=(".vimrc" ".zshrc" ".tmux.conf")

for dotfile in "${DOTFILES[@]}"; do
    SOURCE_PATH="$DOTFILES_DIR/$dotfile"
    TARGET_PATH="$HOME/$dotfile"

    if [ -f "$SOURCE_PATH" ]; then
        if [ -L "$TARGET_PATH" ]; then
            echo "Removing existing symlink: $TARGET_PATH"
            rm "$TARGET_PATH"
        elif [ -f "$TARGET_PATH" ]; then
            echo "Backing up existing file: $TARGET_PATH to $TARGET_PATH.bak"
            mv "$TARGET_PATH" "$TARGET_PATH.bak"
        fi
        echo "Creating symlink: $SOURCE_PATH -> $TARGET_PATH"
        ln -s "$SOURCE_PATH" "$TARGET_PATH"
    else
        echo "Warning: Dotfile not found at $SOURCE_PATH. Skipping symlink for $dotfile."
    fi
done

echo "Environment setup complete!"
echo "Please remember to restart your terminal or run 'source ~/.zshrc' to apply Zsh changes."
echo "Also, open Vim and run ':PluginInstall' to install Vundle plugins."
