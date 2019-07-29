export ZSH=/home/$(whoami)/.oh-my-zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_BASE=/home/$(whoami)/.fzf

ZSH_TMUX_AUTOSTART=false
ZSH_THEME="af-magic"

plugins=(rbenv zsh-autosuggestions git autojump bundler tmux ruby rails ssh-agent fzf zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi
