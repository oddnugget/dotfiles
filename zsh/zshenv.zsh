export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_STATE_HOME="$HOME/.local/state"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=100000
export SAVEHIST=100000

# Ubuntu's /etc/zsh/zshrc runs its own compinit; completions.zsh handles it
skip_global_compinit=1

export VISUAL="nvim"
export EDITOR="$VISUAL"
# . "$HOME/.cargo/env"
