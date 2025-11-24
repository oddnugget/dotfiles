# vim: set ft=zsh

# GIT 
alias gd='git show'
alias gst='git status'

alias ncfg='nvim --cmd "cd $HOME/.config/nvim"'
alias ls='lsd'
alias dot='cd $HOME/dotfiles'

alias fugit="nvim -c \"G\" -c \"only\""
alias today="date -u +%Y-%m-%d"
alias zshso="source ~/.config/zsh/.zshrc"

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
    kubectl exec -it "$pod" -- sh
}

function unlock_devbox () {
    key=$(op read "op://Employee/Devbox Root/root password")
    ssh root@devbox-recovery "echo -n $key | cryptroot-unlock"
}


# Elixir
alias miex="iex -S mix phx.server"

