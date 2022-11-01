#!/usr/bin/env bash

# adds to PATH only if not already exists
# taken from https://superuser.com/a/753948
pathappend() {
  for ARG in "$@"
  do
    if ( [ -d "$ARG" ] || [[ "$ARG" != /* ]] ) && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    else
        echo "ignoring append: $ARG"
    fi
  done
  export PATH
}

pathprepend() {
  for ((i=$#; i>0; i--));
  do
    ARG=$@[i]
    if ( [ -d "$ARG" ] || [[ "$ARG" != /* ]] ) && [[ ":$PATH:" != *":$ARG:"* ]]; then
      PATH="$ARG${PATH:+":$PATH"}"
    else
        echo "ignoring prepend: $ARG"
    fi
  done
  export PATH
}
