#!/bin/bash
export GREP_OPTIONS='--color=auto'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# because why not
alias plz='sudo'

# copies public ssh key to clipboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# [megusta]
alias colors='for code in {0..255}; do echo -e "\e[38;05;${code}m $code: colours!@#$%^&*()"; done'

# process aliases
alias psg='ps -Af | head -1 && ps -Af | grep'

# bower fix for zsh
alias bower='noglob bower'

alias localtunnel='/usr/local/lib/node_modules/localtunnel/bin/client'

alias grp='git rev-parse'
alias grph='git rev-parse HEAD'
alias grpah='git rev-parse --abbrev-ref HEAD'
alias gwds='git diff --no-ext-diff --staged'
alias gba='git branch --all'
alias gwS='git status'
alias gws='git status --short'
alias gbu='BRANCH=$(git rev-parse --abbrev-ref HEAD); git branch --set-upstream-to=origin/$BRANCH $BRANCH'
gptags () {
  for tag in "$@"
  do
    git tag -f $tag && git push -f origin $tag
  done
}

alias hpr='hub pull-request'
alias hbr='hub browse'

alias cib='circleci-cli browse'
alias cin='circleci-cli notify'
alias cic='circleci-cli cancel'
alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias alg='alias | grep'

codi() {
  local syntax="python"
  shift  $((OPTIND - 1))
  local scratch_file=".codi_scratch-$(date +%s).py"
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set showtabline=0 |\
    Codi $syntax" "$@" $scratch_file
  echo "removing scratch file '$scratch_file' ..."
  rm -f $scratch_file
}
