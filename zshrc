#------------------------------------------------------------------------------
# OH-MY-ZSH CONFIGURATION
#------------------------------------------------------------------------------
# Set Oh-My-Zsh location
export ZSH=$HOME/.oh-my-zsh

# TMUX settings
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_UNICODE=true
export ZSH_TMUX_AUTONAME_SESSION=true

# ZSH Completion path
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Zoxide configuration (directory jumping)
export ZOXIDE_CMD_OVERRIDE="cd"

# Oh-My-Zsh plugins grouped by purpose
plugins=(
    # Package managers
    asdf
    brew
    bundler
    gem

    # Languages & frameworks
    ruby
    rails
    rust
    pyenv
    pylint
    mix # Try mix-fast if this is too slow
    terraform

    # DevOps & cloud tools
    ansible
    aws
    docker
    docker-compose

    # Version control
    git

    # System utilities
    sudo
    man
    keychain
    gpg-agent
    fossil
    mosh
    nmap

    # Terminal enhancements
    colorize
    eza
    # fzf
    zsh-interactive-cd
    tmux
    zoxide
    starship

    # Build tools
    rake-fast

    # JavaScript/npm tools
    yarn
)

# Source Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

#------------------------------------------------------------------------------
# EDITOR & TERMINAL CONFIGURATION
#------------------------------------------------------------------------------
# Default editor
export EDITOR="emacsclient -t"

# Man page formatting with bat
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# LSP configuration for Emacs
export LSP_USE_PLISTS=true

# Brew prefix for use in multiple places
export BREW_PREFIX=$(brew --prefix)

#------------------------------------------------------------------------------
# PATH CONFIGURATION
#------------------------------------------------------------------------------
# Cargo (Rust package manager)
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

# Application and development paths
export PATH=~/.config/emacs/bin/:$PATH
export PATH=~/go/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.cabal/bin/:$PATH
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$(brew --prefix)/opt/sqlite/bin:$PATH"

# ASDF version manager
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
. ~/.asdf/plugins/java/set-java-home.zsh

# Haskell
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env

#------------------------------------------------------------------------------
# TOOL-SPECIFIC CONFIGURATION
#------------------------------------------------------------------------------
# Docker configuration
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Docker compose settings
export COMPOSE_BAKE=true

# Eza configuration (modern ls replacement)
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'show-group' yes

# ZSH autosuggestions
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$BREW_PREFIX/share/zsh-syntax-highlighting/highlighters
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion atuin)

# Terminal history with Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# SAML authentication for AWS
# eval "$(saml2aws --completion-script-zsh)"

# 1Password plugin
source $HOME/.config/op/plugins.sh

#------------------------------------------------------------------------------
# ALIASES
#------------------------------------------------------------------------------
# Modern alternatives to classic tools
# alias cd=z # from zoxide! not zcd
# alias code=code-insiders
# alias cp=xcp
# alias find=fd

#------------------------------------------------------------------------------
# LOCAL CONFIGURATION
#------------------------------------------------------------------------------
# Load local/private configuration if it exists
# See zshrc.local.example for examples
if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jvargas/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

export PATH="$PATH:/opt/homebrew/opt/curl/bin"

eval "$(direnv hook zsh)"
