export ZSH=$HOME/.oh-my-zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_BASE=$HOME/.fzf

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

ZSH_TMUX_AUTOSTART=true
ZSH_THEME=""

plugins=(rbenv zsh-autosuggestions git autojump bundler tmux ruby rails ssh-agent fzf zsh-syntax-highlighting mosh pyenv)

source $ZSH/oh-my-zsh.sh

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR="nvim"
export PATH="$HOME/.npm-global/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/curl/bin:$PATH"
