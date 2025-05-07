# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains dotfiles for a development environment primarily focused on:

- Doom Emacs as the primary editor with a literate configuration
- Zsh (with oh-my-zsh) as the shell
- Tmux for terminal multiplexing
- Vim/Neovim as secondary text editors
- Alacritty as a terminal emulator

## Key Configuration Files

- `doom/`: Doom Emacs configuration files
  - `config.org`: Literate configuration with embedded Emacs Lisp
  - `init.el`: Doom modules configuration
  - `packages.el`: Additional package declarations
- `zshrc`: Zsh shell configuration with plugins, environment variables, and aliases
- `tmux/tmux.conf`: Tmux configuration with key bindings and visual customizations
- `vim/vimrc`: Vim editor configuration
- `vim/nvimrc.lua`: Neovim configuration using Lua with LSP and plugin setup
- `alacritty.toml`: Alacritty terminal emulator configuration
- `emacs`: Legacy Emacs configuration with Evil mode and basic org-mode setup

## Common Workflows

### Symlink dotfiles

To set up these dotfiles, create symbolic links from this repository to the appropriate locations:

```bash
# Zsh
ln -sf ~/dotfiles/zshrc ~/.zshrc

# Tmux
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Vim
mkdir -p ~/.vim
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/vimrc.bundles ~/.vimrc.bundles

# Neovim
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vim/nvimrc.lua ~/.config/nvim/init.lua

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

# Doom Emacs
# (First install Doom Emacs: https://github.com/doomemacs/doomemacs)
mkdir -p ~/.config/doom
ln -sf ~/dotfiles/doom/config.org ~/.config/doom/config.org
ln -sf ~/dotfiles/doom/init.el ~/.config/doom/init.el
ln -sf ~/dotfiles/doom/packages.el ~/.config/doom/packages.el
# Run 'doom sync' after linking these files

# Legacy Emacs (if not using Doom)
# ln -sf ~/dotfiles/emacs ~/.emacs
```

### Tmux Commands

- `tmux new -s <session-name>`: Create a new named session
- `tmux attach -t <session-name>`: Attach to an existing session
- `prefix + R`: Reload tmux configuration (prefix is typically Ctrl+b)
- `prefix + S`: Create a new session
- `prefix + %`: Split window horizontally
- `prefix + ´`: Split window vertically
- `prefix + h/j/k/l`: Navigate between panes (Vim-like navigation)
- `prefix + K`: Clear screen and history

### Neovim/Vim Setup

The configuration includes:
- LSP support for multiple languages
- Completion with nvim-cmp
- Mason for LSP and tool management
- Formatter for code formatting

### Emacs Configuration

The Emacs configuration includes:
- Evil mode for Vim keybindings
- Org-mode setup with custom capture templates and agenda
- Doom themes and modeline

## Tool Dependencies

This dotfiles setup depends on:
- Oh-My-Zsh for Zsh enhancements
- Atuin for shell history
- Zoxide for directory jumping
- EZA for ls replacement
- Nerd Fonts (specifically MesloLGSDZ Nerd Font)
- Various language servers for Neovim LSP support