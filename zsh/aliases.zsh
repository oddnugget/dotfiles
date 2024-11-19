# vim: set ft=zsh

# GIT 
alias gd='git show'
alias gst='git status'

alias ncfg='nvim --cmd "cd $HOME/.config/nvim"'
alias ls='lsd'
alias dot='cd $HOME/dotfiles'

alias fugit="nvim -c \"G\" -c \"only\""
alias today="date -u +%Y-%m-%d"

function cat() { bat "$1"; }

# Devbox
function ksh ()
{
    app=$1;
    pod=$(kubectl get pods -l app="$app" -o=jsonpath='{.items[0].metadata.name}' 2>/dev/null);
    result=$?;
    if [ $result -ne 0 ]; then
        echo "could not get pods for $app";
        return $result;
    fi;
    kubectl exec -it "$pod"
}

alias devssh='kitten ssh devbox'

# Elixir
alias miex="iex -S mix phx.server"

