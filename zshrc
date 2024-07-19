test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

export ZSH=$HOME/.oh-my-zsh

ZSH_TMUX_AUTOSTART=false
ZSH_THEME=""

eval "$(starship init zsh)"

plugins=(
  ansible
  aws
  brew
  bundler
  colorize
  docker
  docker-compose
  flutter
  fossil
  gem
  git
  iterm2
  man
  mosh
  nvm
  pyenv
  pylint
  rails
  rake
  rake-fast
  rbenv
  ripgrep
  ruby
  rust
  tmux
  yarn
  zoxide
)

zstyle :omz:plugins:iterm2 shell-integration yes

source $ZSH/oh-my-zsh.sh

export EDITOR="emacsclient -t"

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

export BREW_PREFIX=$(brew --prefix)
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$BREW_PREFIX/share/zsh-syntax-highlighting/highlighters
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

alias cd=z
alias code=code-insiders
alias cp=xcp
alias find=fd
alias ls="eza --icons=always"

autoload -U add-zsh-hook

load_token() {
  local work_folder_pattern="$HOME/src/*" # Change this to path where your work projects lives
  if [[ "$PWD" =~ $work_folder_pattern ]]; then
    export GITHUB_TOKEN=$(security find-generic-password -a "$USER" -s "gh_packages_token" -w)
  fi
}
add-zsh-hook chpwd load_token
load_token

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
