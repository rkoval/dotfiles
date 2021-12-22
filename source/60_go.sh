#!/usr/bin/env bash
if command -v go >> /dev/null; then
  pathappend "$(go env GOPATH)/bin"
  GOPATH=$(go env GOPATH)
  export GOPATH
  GOROOT="$HOMEBREW_HOME/opt/go"
  pathprepend "$GOPATH/bin" "$GOROOT/bin"
fi