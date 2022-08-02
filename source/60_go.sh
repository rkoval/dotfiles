#!/usr/bin/env bash
if command -v go >> /dev/null; then
  GOPATH=$(go env GOPATH)
  export GOPATH
  GOROOT="$HOMEBREW_HOME/opt/go"
  pathprepend "$GOPATH/bin" "$GOROOT/bin"
fi