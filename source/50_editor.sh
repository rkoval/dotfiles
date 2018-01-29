#!/bin/sh

# alias vim to macvim vim for updated version
export EDITOR='/usr/local/Cellar/macvim/8.0-144_3/MacVim.app/Contents/MacOS/Vim' # has to be manual reference otherwise git picks up native vim, not alias
alias vim="\$GIT_EDITOR"
alias vi=vim

if [ ! $SSH_TTY ] && is_osx; then
  export LESSEDIT='mvim ?lm+%lm -- %f'
fi

export VISUAL="mvim"
export PAGER='less'
