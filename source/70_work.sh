#!/usr/bin/env bash
GRAY='\033[1;30m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET_COLOR='\033[0m'

alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

SUBLIME_DIRECTORY="$HOME/Library/Application Support/Sublime Text/Packages/User"
SNIPPET_SYMLINK="$SUBLIME_DIRECTORY/project-snippets"
use-marketing-site-snippets () {
  rm -f "$SNIPPET_SYMLINK"
  set -x
  ln -sf "$HOME/workspace/end-to-end-productions/marketing-site/editor/snippets" "$SNIPPET_SYMLINK"
}

# kubernetes
alias ku='kubectl'

kuns () {
  if [ -z "$1" ]; then
    echo "usage: $0 {namespace}"
    return 1
  fi
  kubectl config set-context $(kubectl config current-context) --namespace=$1
}

kudc () {
  if [[ "$1" == "-f" ]]; then
    shift 1
  fi
  FILE=$1
  kubectl delete -f $FILE && kubectl create -f $FILE
}

alias tf='terraform'
alias jest='nocorrect jest'

export ANDROID_HOME="$HOME/Library/Android/sdk"
pathappend "$ANDROID_HOME/platform-tools"

copy-to-other-git-repo() {
  src="$1"
  dest="$2"
  echo "copying git working tree from ${YELLOW}$src${RESET_COLOR} to ${CYAN}$dest${RESET_COLOR} ..."
  shift 2

  cd "$src"
  changes="$(gwd)"
  if [ -n "$changes" ]; then
    cd "$dest"
    echo "$changes" | git apply
  fi

  cd "$src"
  changes="$(gwds)"
  if [ -n "$changes" ]; then
    cd "$dest"
    echo "$changes" | git apply
  fi
}

alias slack-paste-git-apply='pbpaste | cat - <(echo "") | git apply'

export LC_ALL=en_US.UTF-8

alias bz='bazel'
alias bzr='bazel run'
alias ibzr='ibazel run'
alias bzb='bazel build'
alias bzt='bazel test --test_output=streamed'
alias bztnc='bzt --cache_test_results=no'
alias bzc='bazel clean'
alias bzq='bazel query'
alias bzaq='bazel aquery'
alias bzcq='bazel cquery'