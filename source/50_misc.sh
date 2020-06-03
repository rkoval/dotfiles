#!/bin/bash
export GREP_OPTIONS='--color=auto'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# because why not
alias plz='sudo'

# copies public ssh key to clipboard
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# [megusta]
alias colors='for code in {0..255}; do echo -e "\e[38;05;${code}m $code: colours!@#$%^&*()"; done'

# process aliases
alias psg='ps -Af | head -1 && ps -Af | grep'

# bower fix for zsh
alias bower='noglob bower'

alias localtunnel='/usr/local/lib/node_modules/localtunnel/bin/client'

alias gp='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias grp='git rev-parse'
alias grph="git rev-parse HEAD | tr -d '\\n'"
alias grphc="grph | pbc"
alias grpah='git rev-parse --abbrev-ref HEAD'
alias gwds='git diff --no-ext-diff --staged'
alias gba='git branch --all'
alias gwS='git status'
alias gws='git status --short'
alias gbXa='git branch | grep -v "master" | grep -v "develop" | xargs git branch -D'
alias gbu='BRANCH=$(git rev-parse --abbrev-ref HEAD); git branch --set-upstream-to=origin/$BRANCH $BRANCH'
alias gwt='git worktree'

gbcleanup() {
  git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}

gptags () {
  for tag in "$@"
  do
    git tag -f $tag && git push --no-verify -f origin $tag
  done
}

gcowt() {
  repoFolder=$(basename "$(git rev-parse --show-toplevel)")
  tempDir=$(mktemp -d)
  tempRepoFolder="$tempDir/$repoFolder"
  git worktree add "$tempRepoFolder" $@ && subl "$tempRepoFolder" && cd "$tempRepoFolder"
}

alias hpr='hub pull-request'
alias hbr='hub browse'
alias hbrv='hub browse -- commit/$(grph)'
hbrc() {
  hub browse -c -- commit/$(grph) && osascript -e "display notification \"$(pbpaste)\" with title \"Copied to clipboard\""
  gp || osascript -e "display notification \"Failed to push after copy (probably needs force)\" with title \"Error\""
}

alias cib='circleci browse'
alias cin='circleci notify'
alias cic='circleci cancel'
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
