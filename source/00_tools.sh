#!/usr/bin/env bash

# adds to PATH only if not already exists
# taken from https://superuser.com/a/753948
pathappend() {
  for ARG in "$@"
  do
    if ( [ -d "$ARG" ] || [[ "$ARG" != /* ]] ) && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
  export PATH
}

pathprepend() {
  echo $PATH
  for ((i=$#; i>0; i--));
  do
    ARG=$@[i]
    if ( [ -d "$ARG" ] || [[ "$ARG" != /* ]] ) && [[ ":$PATH:" != *":$ARG:"* ]]; then
      PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
  echo $PATH
  export PATH
}
