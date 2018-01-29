#!/usr/bin/env zsh
# load zgen
source "${HOME}/dotfiles/submodules/zgen/zgen.zsh"

# uncomment to test adding plugins
# zgen reset

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen prezto editor key-bindings 'vi'
    zgen prezto git:status:ignore submodules 'all'
    zgen prezto syntax-highlighting highlighters 'main' 'brackets' 'root'
    zgen prezto prompt theme 'damoekri'
    zgen prezto '*:*' color 'yes'

    zgen prezto

    zgen prezto git
    zgen prezto terminal
    zgen prezto environment
    zgen prezto terminal
    zgen prezto osx
    zgen prezto editor
    zgen prezto history
    zgen prezto history-substring-search
    zgen prezto directory
    zgen prezto spectrum
    zgen prezto utility
    zgen prezto completion
    zgen prezto syntax-highlighting
    zgen prezto python
    zgen prezto fasd
    zgen prezto prompt
    zgen prezto homebrew
    zgen prezto node
    zgen prezto docker

    zgen load djui/alias-tips
    zgen load mattbangert/kubectl-zsh-plugin
    zgen load Dbz/zsh-kubernetes
    zgen load tomsquest/nvm-auto-use.zsh

    # save all to init script
    zgen save
fi

# Customize to your needs...
bindkey '^R' history-incremental-search-backward

setopt nosharehistory

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if $(which kops > /dev/null 2>&1); then
  source <(kops completion zsh)
fi

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export NVM_DIR="$HOME/.nvm"
. $(brew --prefix nvm)/nvm.sh
