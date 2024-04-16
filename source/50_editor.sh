#!/usr/bin/env bash

# alias vim for updated version
export EDITOR='nvim'
alias vim="\$GIT_EDITOR"
alias vi=vim
alias gvim='neovide'

if [ ! $SSH_TTY ] && is_osx; then
  export LESSEDIT='gvim ?lm+%lm -- %f'
fi

export VISUAL="gvim"
export PAGER='less'
export MANPAGER='nvim +Man!'

# jest snapshot files are useless when parsed as js through difftastic and cause it to be very slow without this
export DFT_OVERRIDE_1='*.snapshot.js:text'