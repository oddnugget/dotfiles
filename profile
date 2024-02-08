#!/bin/bash

export DEVBOX=true
export PATH=/opt/devbox/ruby/bin:/opt/devbox/cargo/bin:/devbox/bin:tmp/devbox/gems/bin:$PATH

# Adds paths for symlinks used to make dependencies available to each project.
#
# The symlinks ensure the correct version of dependencies are available. The commands can be
# from software like Ruby or Elixir or from packages like node modules or rubygems.
#
# The paths are set up to work in subdirectories to support commands that need that. For example
# "elm-test" is best run within app/javascript/elm and it in turn runs elm-package and
# elm-make within app/javascript/elm/tests.
#
# The last path is the global fallback to the symlinks for /devbox which includes things like vim, tmux and git.

export PATH=tmp/devbox/binwrappers:../tmp/devbox/binwrappers:../../tmp/devbox/binwrappers:../../../tmp/devbox/binwrappers:../../../../tmp/devbox/binwrappers:../../../../../tmp/devbox/binwrappers:../../../../../../tmp/devbox/binwrappers:../../../../../../../tmp/devbox/binwrappers:../../../../../../../../tmp/devbox/binwrappers:../../../../../../../../../tmp/devbox/binwrappers:../../../../../../../../../../tmp/devbox/binwrappers:../../../../../../../../../../../tmp/devbox/binwrappers:../../../../../../../../../../../../tmp/devbox/binwrappers:../../../../../../../../../../../../../tmp/devbox/binwrappers:../../../../../../../../../../../../../../tmp/devbox/binwrappers:/devbox/tmp/devbox/binwrappers:$PATH

# There apps can store their data so that devbox can backup and restore it as needed, etc.
export DATABASE_ROOT=$HOME/.devbox/data

export GEM_HOME="tmp/devbox/gems"

export GEM_PATH="${GEM_HOME}"
export GEM_PATH="${GEM_PATH}:tmp/devbox/gems_inside_the_current_ruby_install"

export LC_ALL=en_US.UTF-8

# Ruby GC optimization
export RUBY_HEAP_FREE_MIN=100000
export RUBY_HEAP_SLOTS_INCREMENT=300000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=79000000
export RUBY_GC_HEAP_INIT_SLOTS=800000

# Rust / Cargo
export RUSTUP_HOME="/opt/devbox/rustup"
export CARGO_HOME="/opt/devbox/cargo"

# Ensure old tmux splits have access to the latest ssh agent so that you
# don't have to type in your SSH key password after reattaching to an old tmux session.
#
# To reproduce the error this fixes, do:
# ssh devbox
# tmux
# ctrl + b + d
# exit
# ssh devbox
# tmux attach
# ssh somewhere
#
if [ $SSH_AUTH_SOCK ]; then
  ln -sf $(echo $SSH_AUTH_SOCK) /tmp/current_ssh_auth_sock
  if [ $TMUX ]; then
    export SSH_AUTH_SOCK=/tmp/current_ssh_auth_sock
  fi
fi

# Put fzf in PATH
if [ $(basename $SHELL) = "bash" ]; then
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

if [ $(basename $SHELL) = "zsh" ]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# If the machine booted in your home directory, jump to the project root directory instead.
[ $HOME = `pwd` ] && cd /projects

# Disable path cache so that we use the correct versions of dependencies
# depending on the directory we're currently in. In a normal system
# binaries would never be releative to the current path, but devbox
# relies on this.
#
# How to reproduce:
# node -v # in any project that has node
# cd ..
# node -v # should show system node, not any error or the wrong version
set +o hashall
export DEV_HOST=devbox
