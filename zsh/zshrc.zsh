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

alias luamake=/home/odyrag/.local/lua-language-server/3rd/luamake/luamake

if [[ -f /devbox/script/support/profile ]]; then
  source /devbox/script/support/profile
fi

# The devbox profile adds relative PATH entries (tmp/devbox/binwrappers, ...).
# Zed's language servers (e.g. Expert) resolve `elixir` to a relative path that
# Erlang's System.cmd can't re-resolve (:enoent), so prepend an absolute copy
# when Zed is capturing the project environment.
if [[ -n "$ZED_ENVIRONMENT" && -d "$PWD/tmp/devbox/binwrappers" ]]; then
  export PATH="$PWD/tmp/devbox/binwrappers:$PATH"
fi

if [[ -f ~/.env ]]; then
  source ~/.env
fi

if [[ -n "${DEVBOX}" ]]; then
  source /home/odyrag/.config/broot/launcher/bash/br
  eval "$(shadowenv init zsh)"
  export DEV_HOST=devbox
else
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  export PATH=/opt/homebrew/bin:$PATH
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd --hook prompt)"
# eval "$(~/.local/bin/mise activate)"
# shellcheck disable=SC1090
source <(fzf --zsh)

# Completions
autoload -U compinit; compinit;
_comp_options+=(globdots) # hidden files
source "$ZDOTDIR/completions.zsh"

unsetopt autocd
setopt HIST_SAVE_NO_DUPS

bindkey -e


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

if [[ -z "$PROFILE_SOURCED" ]]; then
    source ~/.zprofile
fi

# pnpm
export PNPM_HOME="/home/odyrag/.config/local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
