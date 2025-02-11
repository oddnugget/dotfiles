# vim: set ft=zsh
# $ZDOTDIR/.zshenv -- env vars
# $ZDOTDIR/.zprofile -- executed after login
# $ZDOTDIR/.zshrc -- shell config
# $ZDOTDIR/.zlogin -- after login and shell config
# $ZDOTDIR/.zlogout -- before logout


export PATH=$PATH:$HOME/.local/bin
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=$HOME/.cargo/bin:$PATH

source "$ZDOTDIR/aliases"
source "$ZDOTDIR/wezterm-shell-integration"

alias luamake=/home/odyrag/.local/lua-language-server/3rd/luamake/luamake

if [[ -f /devbox/script/support/profile ]]; then
  source /devbox/script/support/profile
fi

if [[ -n "${DEVBOX}" ]]; then
  source /home/odyrag/.config/broot/launcher/bash/br
  export DEV_HOST=devbox
else
  export PATH=/opt/homebrew/bin:$PATH
  eval "$(rbenv init -)"
fi

eval "$(shadowenv init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd --hook prompt)"
# shellcheck disable=SC1090
source <(fzf --zsh)

# Completions
autoload -U compinit; compinit;
_comp_options+=(globdots) # hidden files
source "$ZDOTDIR/completions.zsh"

unsetopt autocd
setopt HIST_SAVE_NO_DUPS 

# Vim mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char
source "$ZDOTDIR/plugins/cursor_mode"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
