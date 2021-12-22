#!/usr/bin/env bash
if command -v go; then
  pathappend "$(go env GOPATH)/bin"
  GOPATH=$(go env GOPATH)
  export GOPATH
  GOROOT='/usr/local/opt/go'
  pathprepend "$GOPATH/bin" "$GOROOT/bin"
fi