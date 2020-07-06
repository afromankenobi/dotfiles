export ZSH=/home/$(whoami)/.oh-my-zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_BASE=/home/$(whoami)/.fzf

ZSH_TMUX_AUTOSTART=true
ZSH_THEME=""

plugins=(rbenv zsh-autosuggestions git autojump bundler tmux ruby rails ssh-agent fzf zsh-syntax-highlighting mosh)

source $ZSH/oh-my-zsh.sh


if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR="vim"
export PATH="$HOME/.npm-global/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(starship init zsh)"
