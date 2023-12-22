#!/usr/bin/env bash
pathprepend "$(brew --prefix ruby)/bin" "$(brew --prefix)/lib/ruby/gems/3.2.0/bin"
eval "$(rbenv init - zsh)"
