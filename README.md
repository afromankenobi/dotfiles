# My dotfiles

I use Doom Emacs, Neovim, and Tmux in my workflow. These are my dotfiles.

## Configuration Files

- **Doom Emacs**: Literate configuration using org-mode
- **Neovim/Vim**: Configuration for both Vim and Neovim
- **Tmux**: Terminal multiplexer configuration
- **Alacritty**: Terminal emulator configuration
- **Zsh**: Shell configuration with oh-my-zsh

## Installation

### Prerequisites

You can install all required packages using Homebrew:

```bash
# Option 1: Install only essential packages (recommended for new setup)
brew bundle install --file=Brewfile.minimal

# Option 2: Install everything from the full Brewfile (all currently installed packages)
brew bundle install --file=Brewfile

# After installation, install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**About the Brewfiles:**
- `Brewfile.minimal`: Curated list of essential packages required for dotfiles to work
- `Brewfile`: Complete snapshot of all currently installed Homebrew packages (for reference)

Manual prerequisites (if not using Brewfile):
- [Doom Emacs](https://github.com/doomemacs/doomemacs) (install before symlinking config)
- Oh-My-Zsh
- Neovim (optional)
- Tmux (optional)
- Alacritty (optional)

### Setup Instructions

Clone this repository:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

#### Zsh

```bash
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

# Create local config file for machine-specific settings
cp ~/dotfiles/zsh/zshrc.local.example ~/.zshrc.local
# Edit ~/.zshrc.local with your machine-specific settings

source ~/.zshrc
```

#### asdf

[asdf](https://asdf-vm.com/) is a version manager for multiple languages/tools. The configuration includes:
- `tool-versions`: Defines which versions to use globally
- `default-*` files: Auto-install packages when new versions are installed

```bash
# Symlink asdf configuration
ln -sf ~/dotfiles/asdf/tool-versions ~/.tool-versions

# Symlink default package files (creates ~/.default-* files)
ln -sf ~/dotfiles/asdf/default-cargo-crates ~/.default-cargo-crates
ln -sf ~/dotfiles/asdf/default-elixir-packages ~/.default-elixir-packages
ln -sf ~/dotfiles/asdf/default-gems ~/.default-gems
ln -sf ~/dotfiles/asdf/default-golang-packages ~/.default-golang-packages
ln -sf ~/dotfiles/asdf/default-npm-packages ~/.default-npm-packages
ln -sf ~/dotfiles/asdf/default-python-packages ~/.default-python-packages

# Install versions defined in .tool-versions
# This will auto-install missing plugins and then install the versions
asdf install
```

**Note:** The `default-*` files automatically install packages whenever you install a new version of that language. For example, `default-gems` installs Ruby gems automatically when you run `asdf install ruby <version>`.

#### Tmux

```bash
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Reload tmux configuration if already running
tmux source-file ~/.tmux.conf
```

#### Doom Emacs

**Important:** Install Doom Emacs first, then symlink these config files.

```bash
# 1. Install Doom Emacs if not already installed
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# 2. Remove default Doom config files (if they exist)
rm -f ~/.config/doom/config.el ~/.config/doom/init.el ~/.config/doom/packages.el

# 3. Create symlinks to dotfiles
ln -sf ~/dotfiles/doom/config.org ~/.config/doom/config.org
ln -sf ~/dotfiles/doom/packages.org ~/.config/doom/packages.org
ln -sf ~/dotfiles/doom/init.el ~/.config/doom/init.el

# 4. Run doom sync to generate config.el and packages.el from .org files
~/.config/emacs/bin/doom sync
```

**About Doom's literate configuration:**
- `config.org` and `packages.org` are the SOURCE files (edit these)
- `config.el` and `packages.el` are GENERATED automatically (never edit these)
- Only the `.org` and `init.el` files are tracked in git
- The generated `.el` files are in `.gitignore`

After editing `config.org` or `packages.org`, run `doom sync` to regenerate the `.el` files.

#### Neovim (Optional)

```bash
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vim/nvimrc.lua ~/.config/nvim/init.lua
```

#### Vim (Optional)

```bash
mkdir -p ~/.vim
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/vimrc.bundles ~/.vimrc.bundles
```

#### Alacritty (Optional)

```bash
mkdir -p ~/.config/alacritty
ln -sf ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
```

## Workflow

### Editing Doom Emacs Configuration

1. Edit `~/dotfiles/doom/config.org` or `~/dotfiles/doom/packages.org`
2. Run `doom sync` to tangle and apply changes
3. Restart Emacs or run `M-x doom/reload`

### Adding Machine-Specific Settings

For machine-specific settings (API keys, local paths, etc.):

- **Zsh**: Edit `~/.zshrc.local` (not tracked in git)
- Use `~/dotfiles/zsh/zshrc.local.example` as a template

## Maintaining Dependencies

### Updating Brewfile

When you install new Homebrew packages that should be part of the dotfiles:

```bash
# 1. Regenerate the full Brewfile from your current installation
brew bundle dump --file=Brewfile --force

# 2. Manually add essential packages to Brewfile.minimal if needed

# 3. Commit both files
git add Brewfile Brewfile.minimal
git commit -m "Update Brewfile with new dependencies"
```

### Cleanup Unused Packages

To remove packages not listed in Brewfile:

```bash
# Preview what would be removed
brew bundle cleanup --file=Brewfile

# Actually remove them
brew bundle cleanup --file=Brewfile --force
```

## Documentation

- `CLAUDE.md`: Guidance for AI assistants working with this codebase
- `RATIONALE.md`: Explains the design decisions and organization principles
- `Brewfile`: Complete snapshot of all Homebrew packages
- `Brewfile.minimal`: Essential packages for dotfiles functionality
