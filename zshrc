#USER CONFIG

# I think this has to do with kitty remote ssh
# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     export VISUAL="nvr --remote-tab-wait +'set bufhidden=delete'"
# else
#     export VISUAL="nvim"
# fi
#

# Wezterm.nvim navigator
[ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"



export EDITOR="$VISUAL"

PATH=$PATH:$HOME/.local/bin/

source ~/.zsh/aliases
alias luamake=/home/odyrag/.local/lua-language-server/3rd/luamake/luamake
source .zsh/wezterm-shell-integration
source <(fzf --zsh)

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd --hook prompt)"
eval "$(shadowenv init zsh)"

source ~/.profile

if [[ -n "${DEVBOX}" ]]; then
  source /devbox/script/support/profile
  source /home/odyrag/.config/broot/launcher/bash/br
else
  eval "$(rbenv init -)"
fi

unsetopt autocd
source $HOME/.zsh/user-env
export PATH="$PATH:/usr/lib/python3/"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
