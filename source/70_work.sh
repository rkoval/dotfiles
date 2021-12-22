#!/usr/bin/env bash
GRAY='\033[1;30m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET_COLOR='\033[0m'

alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

dockercleanup() {
  docker rmi $(docker images --filter "dangling=true" -q --no-trunc) \
  docker rm $(docker ps -qa --no-trunc --filter "status=exited")
}

alias vaulte="EDITOR=\$GIT_EDITOR ansible-vault edit --vault-password-file ~/.ssh/vault_pass.txt"
alias vaultv='ansible-vault view --vault-password-file ~/.ssh/vault_pass.txt'
alias vaulten='ansible-vault encrypt --vault-password-file ~/.ssh/vault_pass.txt'
alias vaultde='ansible-vault decrypt --vault-password-file ~/.ssh/vault_pass.txt'
alias vault='ansible-vault --vault-password-file ~/.ssh/vault_pass.txt'

export ANSIBLE_VAULT_PASSWORD_FILE=~/.ssh/vault_pass.txt

alias dco='docker-compose'

dcou () {
  if [ -z "$1" ]; then
    echo "usage: $0 {images...}"
    return 1
  fi
  docker-compose stop $@ && docker-compose build $@ && docker-compose up -d --no-deps $@
}

dcodbu () {
  IMAGE=$1
  docker-compose down $IMAGE && docker-compose build $IMAGE && docker-compose up $IMAGE
}

# kubernetes
alias emk='eval $(minikube docker-env)'
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
alias pa='pachctl'
alias jest='nocorrect jest'

alias jg1="cd ~/workspace/guilded && source guilded_profile.sh"
alias jg2="cd ~/workspace/guilded2 && source guilded_profile.sh"
alias jg3="cd ~/workspace/guilded3 && source guilded_profile.sh"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

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

c2o() {
  src="$GUILDED_ROOT_DIR"
  if ! pwd | grep guilded3 >> /dev/null; then
    dest="$HOME/workspace/guilded3"
  else
    dest="$HOME/workspace/guilded"
  fi
  copy-to-other-git-repo "$src" "$dest"

  echo -e "\n${GRAY}current working tree:${RESET_COLOR}"
  gws
  cd "$dest"
  echo -e "\n${GRAY}updated destination working tree:${RESET_COLOR}"
  gws
  cd "$src"
}

alias sshuserver='ec2connect i-012c81a7a5763cd0a'
alias sshuserverstress='ec2connect i-069ab7d5062ca8196'
alias sshmodbot='ec2connect i-0a4789ff84f0393ef'
