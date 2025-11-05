#!/usr/bin/env zsh
export NVM_AUTO_USE=true
export ZSH_AUTOSUGGEST_USE_ASYNC=true

# prevent error on init
# see https://apple.stackexchange.com/a/340718/69081
autoload -Uz compinit
compinit

# load zgen
source "${HOME}/dotfiles/submodules/zgen/zgen.zsh"

# uncomment to test adding plugins
# zgen reset

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    # prezto config
    zgen prezto editor key-bindings 'vi'
    zgen prezto git:status:ignore submodules 'all'
    zgen prezto syntax-highlighting highlighters 'main' 'brackets' 'root'
    zgen prezto prompt theme 'rkoval'
    zgen prezto '*:*' color 'yes'

    zgen prezto

    # prezto modules
    zgen prezto git
    zgen prezto terminal
    zgen prezto environment
    zgen prezto terminal
    zgen prezto osx
    zgen prezto editor
    zgen prezto history
    zgen prezto history-substring-search
    zgen prezto directory
    zgen prezto utility
    zgen prezto completion
    zgen prezto syntax-highlighting
    zgen prezto python
    zgen prezto fasd
    zgen prezto prompt
    zgen prezto homebrew
    command -v docker > /dev/null && zgen prezto docker

    # use custom nvm and npm completion since prezto node module is slow
    # zgen load lukechilds/zsh-nvm
    # doesn't work presently?
    # zgen load lukechilds/zsh-better-npm-completion

    # misc github plugins
    zgen load djui/alias-tips
    command -v kubectl > /dev/null && zgen load mattbangert/kubectl-zsh-plugin
    command -v kubectl > /dev/null && zgen load Dbz/zsh-kubernetes
    command -v docker-compose > /dev/null && zgen load docker/compose contrib/completion/zsh
    command -v docker > /dev/null && zgen load docker/cli contrib/completion/zsh
    command -v fly > /dev/null && zgen load sbodiu-pivotal/fly-zsh-autocomplete-plugin

    # save all to init script
    zgen save
fi

# Customize to your needs...

export KEYTIMEOUT=1
setopt appendhistory
setopt incappendhistory
unsetopt sharehistory

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

bindkey '^R' history-incremental-search-backward
bindkey '^N' down-history
bindkey '^P' up-history
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh

    bindkey '^R' fzf-history-widget
    # ^N and ^P are natively handled in fzf,
    # so just make them open the widget because it's the same exact number of keypresses
    bindkey '^N' fzf-history-widget
    bindkey '^P' fzf-history-widget
fi

# source bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

eval "$(direnv hook zsh)"

unsetopt correct
unsetopt correct_all

# bun completions
[ -s "/Users/ryankoval/.bun/_bun" ] && source "/Users/ryankoval/.bun/_bun"

which uv > /dev/null 2>&1 && eval "$(uv generate-shell-completion zsh)"
which uvx > /dev/null 2>&1 && eval "$(uvx --generate-shell-completion zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
