export ZSH=$HOME/.oh-my-zsh
export DPRINT_INSTALL="/home/odyrag/.dprint"
export PATH="$DPRINT_INSTALL/bin:$PATH"
export PATH="$PATH:/home/odyrag/.yarn/bin"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#USER CONFIG

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr --remote-tab-wait +'set bufhidden=delete'"
else
    export VISUAL="nvim"
fi

export EDITOR="$VISUAL"

PATH=$PATH:$HOME/.local/bin/

export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"

source ~/.zsh/aliases
alias luamake=/home/odyrag/.local/lua-language-server/3rd/luamake/luamake

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd --hook prompt)"

source ~/.profile



if [[ -n "${DEVBOX}" ]]; then
  eval "$(shadowenv init zsh)"
  source /home/odyrag/.config/broot/launcher/bash/br
else
  PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="$PATH:$HOME/.rvm/bin"
fi

unsetopt autocd
source $HOME/.zsh/user-env
# source $HOME/.zsh/wezterm-shell-integration
export PATH="$PATH:$HOME/.local/bin"
