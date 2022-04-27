#!/usr/bin/env bash
# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 022

# Easier navigation: .., ..., -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# File size
alias fs="stat -f '%z bytes'"

# Recursively delete `.DS_Store` files
alias dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Aliasing eachdir like this allows you to use aliases/functions as commands.
alias eachdir=". eachdir"
alias ll="ls -l"
alias la="ll -a"
alias less="less -j 4"
alias lg="lazygit --use-config-file $HOME/.config/lazygit/config.yml"

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}
