#!/usr/bin/env bash
pathprepend "./node_modules/.bin"
pathappend "$HOME/.yarn/bin" "$HOME/.config/yarn/global/node_modules/.bin"

alias nr='npm run'
alias nrd='npm run dev'
alias nrs='npm start'
alias nri='npm install && npm prune'
