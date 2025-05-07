export ZSH=$HOME/.oh-my-zsh

export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_UNICODE=true
export ZSH_TMUX_AUTONAME_SESSION=true

export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

export DISABLE_FZF_KEY_BINDINGS="true"
export FZF_DEFAULT_COMMAND='rg --column --line-number --color=always --smart-case --files --hidden --glob "!.git/*"'
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

export ZOXIDE_CMD_OVERRIDE="cd"

plugins=(
    asdf
    ansible
    aws
    brew
    bundler
    colorize
    docker
    docker-compose
    eza
    fossil
    keychain
    gpg-agent
    gem
    git
    man
    mosh
    nmap
    pyenv
    pylint
    ruby
    rails
    starship
    fzf
    zsh-interactive-cd
    mix # Try mix-fast if this is too slow
    terraform
    rake-fast
    rust
    tmux
    sudo
    yarn
    zoxide
)

source $ZSH/oh-my-zsh.sh

export EDITOR="emacsclient -t"

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

export BREW_PREFIX=$(brew --prefix)
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$BREW_PREFIX/share/zsh-syntax-highlighting/highlighters
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion atuin)

. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

# alias cd=z # from zoxide! not zcd
alias code=code-insiders
alias cp=xcp
alias find=fd

autoload -U add-zsh-hook

# Load local/private configuration if it exists
# See zshrc.local.example for examples
if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

export PATH=~/.config/emacs/bin/:~/go/bin:~/.local/bin:$PATH

. ~/.asdf/plugins/java/set-java-home.zsh

eval "$(saml2aws --completion-script-zsh)"
source /Users/jvargas/.config/op/plugins.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export LSP_USE_PLISTS=true

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Add .NET Core SDK tools
export PATH="$PATH:/Users/jvargas/.dotnet/tools"

[ -f "/Users/jvargas/.ghcup/env" ] && . "/Users/jvargas/.ghcup/env" # ghcup-env

export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jvargas/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Docker daemon says bake is faster. Let's try
COMPOSE_BAKE=true
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# Eza config
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'show-group' yes

export PATH=~/.npm-global/bin:~/.cabal/bin/:$PATH

export COMPOSE_BAKE=true
