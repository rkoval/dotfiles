#!/usr/bin/env bash

# alias vim for updated version
export EDITOR='nvim'
alias vim="\$GIT_EDITOR"
alias vi=vim

if [ ! $SSH_TTY ] && is_osx; then
  export LESSEDIT='vimr ?lm+%lm -- %f'
fi

export VISUAL="vimr"
export PAGER='less'
export MANPAGER='nvim +Man!'
