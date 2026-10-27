# vim: set ft=zsh
# $ZDOTDIR/.zshenv -- env vars
# $ZDOTDIR/.zprofile -- executed after login
# $ZDOTDIR/.zshrc -- shell config
# $ZDOTDIR/.zlogin -- after login and shell config
# $ZDOTDIR/.zlogout -- before logout

# Keep PATH entries unique
typeset -U path

path+=("$HOME/.local/bin")
path=("$HOME/.cargo/bin" $path)

if [[ $OSTYPE == darwin* ]]; then
  path=(/opt/homebrew/opt/openjdk/bin $path)
fi

source "$ZDOTDIR/aliases"

alias luamake="$HOME/.local/lua-language-server/3rd/luamake/luamake"

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
  source "$XDG_CONFIG_HOME/broot/launcher/bash/br"
  eval "$(shadowenv init zsh)"
  export DEV_HOST=devbox
else
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  if [[ $OSTYPE == darwin* ]]; then
    path=(/opt/homebrew/bin $path)
  fi
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd --hook prompt)"
# eval "$(~/.local/bin/mise activate)"

# Completions (compinit runs in completions.zsh)
source "$ZDOTDIR/completions.zsh"

# ~/.fzf.zsh adds ~/.fzf/bin to PATH before loading the fzf integration
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  # shellcheck disable=SC1090
  source <(fzf --zsh)
fi

unsetopt autocd
setopt HIST_SAVE_NO_DUPS

bindkey -e

if [[ $OSTYPE == darwin* ]]; then
  path=(/opt/homebrew/opt/postgresql@18/bin $path)
fi

if [[ -z "$PROFILE_SOURCED" && -f ~/.zprofile ]]; then
  source ~/.zprofile
fi

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
