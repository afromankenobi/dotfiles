# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository with a focus on:
- **Doom Emacs** (primary editor) with literate configuration approach
- **Zsh** with oh-my-zsh for shell environment
- **Tmux** for terminal multiplexing
- **Vim/Neovim** as secondary editors

## Configuration Architecture

### Literate Configuration Pattern (Doom Emacs)

The Doom Emacs configuration uses literate programming for most config files:

**What is literate?**
- `doom/config.org` → generates → `doom/config.el` (via tangling)
- `doom/packages.org` → generates → `doom/packages.el` (via tangling)
- `doom/init.el` → stays as `.el` (Doom convention for module flags)

**Why is `init.el` not literate?**
- It's mostly just enabling/disabling Doom modules with flags
- Changes infrequently (only when adding/removing major features)
- Doom community convention is to keep it as `.el`
- The file is self-documenting with comments
- *Could* be converted to `init.org` but offers minimal benefit

**CRITICAL: Only edit the `.org` source files, never the generated `.el` files!**

The `.el` files are automatically generated when you:
- Run `doom sync`
- Save a `.org` file with auto-tangle enabled
- Manually tangle with `C-c C-v t` in Emacs

The generated `.el` files are in `.gitignore` and should not be committed.

**Literate workflow:**
1. Edit `config.org` or `packages.org`
2. Run `doom sync` to tangle and apply changes
3. Only the `.org` files are tracked in git

Key architectural decisions in the Emacs config:
- Most settings wrapped in `after!` blocks to load after Doom's defaults
- File/directory variables (like `org-directory`) set before package loading
- LSP using `eglot` instead of `lsp-mode`
- GitHub Copilot integrated with Corfu completion framework

### Modular Shell Configuration (Zsh)

The `zshrc` follows a strict loading order that should be preserved:
1. Oh-My-Zsh configuration (must load first, enables plugins)
2. Editor & terminal settings
3. PATH configuration (all in one section)
4. Tool-specific configuration
5. Aliases (after tools are configured)
6. Local configuration (last, can override anything)

**Important**: Private/machine-specific settings go in `~/.zshrc.local` (not tracked in git). See `zshrc.local.example` for structure.

### Named Colors Pattern (Tmux)

Tmux configuration defines colors with semantic names at the top:
- Color definitions: `color_orange="colour208"`
- Functional assignments: `color_active="$color_orange"`

To change the color scheme, modify only the color definitions section. This pattern makes theme changes centralized and clear.

## Common Commands

### Doom Emacs

```bash
# Apply configuration changes after editing config.org
doom sync

# Upgrade Doom and packages
doom upgrade

# Rebuild Doom (if things break)
doom build

# Check for issues
doom doctor
```

### Tmux Key Bindings

Custom keybindings (prefix is typically Ctrl+b):
- `prefix + R`: Reload tmux configuration
- `prefix + S`: Create new session
- `prefix + h/j/k/l`: Navigate panes (Vim-style)
- `prefix + K`: Clear screen and history
- `prefix + ´`: Split vertically (custom)
- Copy mode: `prefix + ` ` (backtick)
- Paste: `prefix + +`

### Installation/Symlinking

**Important:** The files in this repository must be **symlinked** to their target locations, not copied.

See `README.md` for complete installation instructions. Key points:

1. **Install Doom Emacs first** before symlinking config files
2. **Symlink the `.org` source files**, not the generated `.el` files
3. **Run `doom sync`** after symlinking to generate `.el` files
4. **Never copy files** - always use `ln -sf` to create symlinks

Quick reference for Doom:
```bash
# Symlink source files
ln -sf ~/dotfiles/doom/config.org ~/.config/doom/config.org
ln -sf ~/dotfiles/doom/packages.org ~/.config/doom/packages.org
ln -sf ~/dotfiles/doom/init.el ~/.config/doom/init.el

# Generate .el files
doom sync
```

## Design Principles (from RATIONALE.md)

These principles guide configuration decisions:

1. **Clarity Over Brevity**: Verbose but clear is preferred over concise but cryptic
2. **Separation of Concerns**: Each tool has its own file; sections are clearly grouped
3. **Privacy & Security**: Sensitive data goes in local files (not tracked)
4. **Progressive Enhancement**: Configs work even when some tools are missing
5. **Visual Hierarchy**: Section headers and comments create scannable structure

## Key Files

**Doom Emacs (literate sources - these are tracked in git):**
- `doom/config.org`: Literate Doom Emacs configuration (SOURCE - edit this)
- `doom/packages.org`: Package declarations (SOURCE - edit this)
- `doom/init.el`: Doom modules declaration (kept as `.el` by convention)

**Doom Emacs (generated - NOT tracked in git):**
- `doom/config.el`: Generated from `config.org` (DO NOT EDIT)
- `doom/packages.el`: Generated from `packages.org` (DO NOT EDIT)

**Other configuration:**
- `zshrc`: Shell configuration with strict loading order
- `zshrc.local.example`: Template for machine-specific settings
- `tmux/tmux.conf`: Tmux with named colors pattern
- `RATIONALE.md`: Explains the "why" behind configuration choices

## Dependencies

Core tools expected to be installed:
- Doom Emacs with MesloLGSDZ Nerd Font
- Oh-My-Zsh
- Atuin (shell history)
- Zoxide (directory jumping, aliased to `cd`)
- Eza (modern ls replacement)
- direnv (directory-specific environment variables)

For Emacs LSP support:
- Language servers vary by language (configured in `doom/config.org`)
- Elixir: NextLS or ElixirLS
- Ruby: ruby-lsp
- Markdown: marksman

## Cross-Platform Considerations

The tmux configuration adapts to the platform:
- macOS: Uses `pbcopy` for clipboard
- Linux: Uses `xclip` or `xsel` if available
- Ruby/Rails version display: Only shows if commands exist
