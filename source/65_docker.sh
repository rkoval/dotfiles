#!/usr/bin/env bash
GRAY='\033[1;30m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET_COLOR='\033[0m'

dockercleanup() {
  docker rmi $(docker images --filter "dangling=true" -q --no-trunc) \
  docker rm $(docker ps -qa --no-trunc --filter "status=exited")
}

alias dco='docker compose'
alias ds='docker sandbox'
alias dsr='docker sandbox run'

dcou () {
  if [ -z "$1" ]; then
    echo "usage: $0 {images...}"
    return 1
  fi
  docker compose stop $@ && docker compose build $@ && docker compose up -d --no-deps $@
}

dcodbu () {
  IMAGE=$1
  docker compose down $IMAGE && docker compose build $IMAGE && docker compose up $IMAGE
}