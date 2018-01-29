#!/bin/bash
alias v='vagrant'
alias vu='vagrant up'
alias vd='vagrant destroy'
alias vh='vagrant halt'
alias vs='vagrant suspend'

alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

export GOPATH=/nastygoat/go
export PATH=$PATH:$GOPATH/bin

alias pys='py setup.py'
alias pyst='pys test'

dockercleanup() {
  docker rmi $(docker images --filter "dangling=true" -q --no-trunc) \
  docker rm $(docker ps -qa --no-trunc --filter "status=exited")
}

# don't generate .pyc
export PYTHONDONTWRITEBYTECODE=1

# pyenv
export PYENV_ROOT=/usr/local/var/pyenv
export PATH="$PYENV_ROOT/shims:$PATH:/usr/local/bin"

export VIRTUAL_ENV=venv

# syntastic pylint
LC_CTYPE=en_US.UTF-8
export LC_CTYPE

alias sba='source venv/bin/activate || source bin/activate'
alias venvinit='virtualenv venv -p $(which python) && sba && pip install --upgrade pip && pip install -r requirements.txt'

# server aliases
alias a3t='ssh analytics3 tail -f /var/log/nodejs/dash.log -n 500'
alias aqat='ssh ad-dash-qa tail -f /var/log/nodejs/dash.log -n 500'

alias vaulte="EDITOR=\$GIT_EDITOR ansible-vault edit --vault-password-file ~/.ssh/vault_pass.txt"
alias vaultv='ansible-vault view --vault-password-file ~/.ssh/vault_pass.txt'
alias vaulten='ansible-vault encrypt --vault-password-file ~/.ssh/vault_pass.txt'
alias vaultde='ansible-vault decrypt --vault-password-file ~/.ssh/vault_pass.txt'
alias vault='ansible-vault --vault-password-file ~/.ssh/vault_pass.txt'

sshsdev () {
  IP=$1
  ssh ec2-user@$IP -i ~/.ssh/sdev_rsa
}

sshpub () {
  IP=$1
  ssh ec2-user@$IP -i ~/.ssh/publishing.pem
}

sshcol () {
  IP=$1
  ssh ec2-user@$IP -i ~/.ssh/acds-collabs.pem
}

sshrkoval () {
  IP=$1
  ssh ec2-user@$IP -i ~/.ssh/aws-sdev-rkoval.pem
}

export AWS_DEFAULT_REGION=us-west-2
export ANSIBLE_VAULT_PASSWORD_FILE=~/.ssh/vault_pass.txt

alias cqlshprod='cqlsh --ssl --cqlshrc ~/.cassandra/cqlshrc-prod'
alias cqlshsdev='cqlsh --ssl --cqlshrc ~/.cassandra/cqlshrc-sdev'
alias cqlshpub='cqlsh --ssl --cqlshrc ~/.cassandra/cqlshrc-pub'

alias dco='docker-compose'
alias dcobrew='brew unlink docker-compose && brew link --overwrite docker-compose'
dpq () {
  docker push quay.io/rewardstyle/$1
}

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
