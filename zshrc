test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

export ZSH=$HOME/.oh-my-zsh
export FZF_BASE=$HOME/.fzf

export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
export FZF_DEFAULT_OPTS="--ansi"
export FZF_COMPLETION_OPTS='--border --info=inline'

export FZF_RG_CMD=""

rg_fzf_preview() {
  local query="$1"
  local file="${2:-.}"
  local context=10

  rg --column --line-number --no-heading --color=always --smart-case "$query" "$file" | \
  fzf --ansi \
      --delimiter : \
      --bind 'ctrl-space:toggle-preview' \
      --preview-window=right,60% \
      --preview "line_start=\$(expr {2} - $context); line_end=\$(expr {2} + $context); bat --color=always --style=header,grid --line-range \$line_start:\$line_end {1}"
}

alias rgp="rg_fzf_preview"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

ZSH_TMUX_AUTOSTART=false
ZSH_THEME=""

eval "$(starship init zsh)"

plugins=(
  ansible
  aws
  bundler
  docker
  docker-compose
  flutter
  fossil
  fzf
  gem
  git
  man
  mosh
  nvm
  rails
  rake-fast
  rbenv
  ruby
  rust
  tmux
  zoxide
  yarn
  brew
)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/broot/launcher/bash/br
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export EDITOR="vim"

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

alias ls=exa
alias cd=z
alias cp=xcp
alias find=fd
alias python=python3

autoload -U add-zsh-hook

load_token() {
  local diligent_folder_pattern="$HOME/src/*" # Change this to path where your work projects lives
  if [[ "$PWD" =~ $diligent_folder_pattern ]]; then
    export GITHUB_TOKEN=$(security find-generic-password -a "$USER" -s "diligent_gh_packages_token" -w)
  fi
}
add-zsh-hook chpwd load_token
load_token

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

eval "$(atuin init zsh)"

