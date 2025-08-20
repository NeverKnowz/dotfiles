# Dotfiles Setup Guide

> A simple, customizable starter kit for setting up your environment with Zsh, Vim, and Tmux. This repository is intended for personal use but is bare-bones enough to be a useful template.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Customization](#customization)
- [Features](#features)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)

---

## Prerequisites

Before you begin, ensure you have the following installed:

- **Supported Operating Systems**: Currently set up to work on MacOS (Brew), Debian (apt), and Arch (pacman), but adding more support is trivial. If you don't prefer those package managers, you can easily modify the `install.sh` script to suit your needs.
- **Git**: [Download Git](https://git-scm.com/)
- **Terminal**: A modern terminal emulator with Unicode support
- **Optional**: Basic familiarity with Zsh, Vim, and Tmux

---

## Quick Start

```sh
git clone https://github.com/NeverKnowz/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

---

## Installation

### 1. Clone the Repository

```sh
git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
```

### 2. Navigate to the Directory

```sh
cd ~/.dotfiles
```

### 3. Make the Setup Script Executable

```sh
chmod +x install.sh
```

### 4. Run the Installation

```sh
./install.sh
```

The script will automatically:
- Install required tools (if not already present)
- Backup existing configuration files
- Symlink new configuration files
- Configure Zsh as your default shell

---

## Customization

### Before Installation

To customize your setup before running the installation:

#### Modifying Tools and Applications
- Edit `install.sh` to add or remove applications
- Add new tools to the `REQUIRED_TOOLS` array (section 2 of the script)

#### Vim Configuration
- **Plugin Manager**: Swap out Vundle for your preferred manager (Vim-Plug, Pathogen, etc.)
- **Theme**: Update `.vimrc` to change from the default One Dark theme
- **Plugins**: Modify the plugin list in `.vimrc` to suit your workflow

#### Zsh Configuration
- **Theme**: Edit `.zshrc` to change from the default af-magic theme
- **Functionality**: Add custom aliases, functions, or Zsh plugins
- **Shell Options**: Modify shell behavior and environment variables

#### Tmux Configuration
- **Key Bindings**: Customize key mappings in `.tmux.conf`
- **Appearance**: Modify status bar and color schemes
- **Plugins**: Add Tmux plugins for extended functionality

### After Installation

You can modify configuration files directly in your home directory:
- `~/.vimrc` - Vim configuration
- `~/.zshrc` - Zsh configuration  
- `~/.tmux.conf` - Tmux configuration

---

## Troubleshooting

### Permission Denied When Running install.sh

**Problem**: `Permission denied` error when executing `./install.sh`

**Solution**: Ensure the script has executable permissions:
```sh
chmod +x install.sh
```

### Vim Plugins Not Installing

**Problem**: Vim plugins fail to install automatically

**Solutions**:
1. Verify Vundle is properly installed and configured in `.vimrc`
2. Open Vim and manually run the plugin installation:
   ```vim
   :PluginInstall
   ```
3. If using a different plugin manager, run the appropriate command:
   - **Vim-Plug**: `:PlugInstall`
   - **Pathogen**: Manually git clone plugins to `~/.vim/bundle/`

### Zsh Theme Not Displaying Correctly

**Problem**: af-magic theme appears broken or missing elements

**Solutions**:
1. Ensure your terminal supports Unicode and 256 colors
2. Install a powerline-compatible font (e.g., Fira Code, Source Code Pro)
3. Reload your Zsh configuration:
   ```sh
   source ~/.zshrc
   ```
4. Check if Oh My Zsh is properly installed (if theme depends on it)

### Tmux Mouse Mode Not Working

**Problem**: Mouse interactions don't work in Tmux

**Solutions**:
1. Verify your terminal emulator supports mouse events
2. Check that mouse mode is enabled in `~/.tmux.conf`:
   ```
   set -g mouse on
   ```
3. Restart Tmux after configuration changes:
   ```sh
   tmux kill-server
   tmux
   ```

### Shell Not Changing to Zsh

**Problem**: Default shell remains unchanged after installation

**Solution**: Manually change your default shell:
```sh
chsh -s $(which zsh)
```
Log out and back in for changes to take effect.

---

## FAQ

### Q: Will this overwrite my existing configurations?

**A**: The installation script creates backups of existing configuration files before making changes. Look for `.bak` files in your home directory.

### Q: Can I add my own customizations?

**A**: Absolutely! Fork the repository and modify the configuration files to suit your preferences. The setup is designed to be easily customizable.

### Q: What if I want to uninstall?

**A**: Remove the symlinked configuration files and restore your backups:
```sh
rm ~/.vimrc ~/.zshrc ~/.tmux.conf
# Restore backups if they exist
mv ~/.vimrc.bak ~/.vimrc
mv ~/.zshrc.bak ~/.zshrc
mv ~/.tmux.conf.bak ~/.tmux.conf
```

---

## Contributing

This repository is primarily for personal use, but contributions and suggestions are welcome! 

### Reporting Issues
If you encounter problems or have suggestions for improvements, please [open an issue](https://github.com/your-username/dotfiles/issues).

---

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

---

<div align="center">

**[⬆ Back to Top](#dotfiles-setup-guide)**

</div>
